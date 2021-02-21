module ClassHDL

    class StructBlock <  ClearSdlModule
        def initialize(belong_to_module)
            @belong_to_module = belong_to_module
            super()
        end

        def method_missing(name,*args,&block)
            ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
                @belong_to_module.send(name,*args,&block)
            end
        end
    end

    def self.Struct(name,sdlm,pre_type,&block) 
        tmp_sm = ClassHDL::StructBlock.new(sdlm)
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
            tmp_sm.instance_exec(&block)
        end

        str = (tmp_sm.vars_define_inst + "\n")
        str.gsub!(/\/\/.*/,"")
        str.gsub!(/[\t|\n]+/m,"\n")
        unless pre_type.to_s == 'union'
            head_str = "typedef struct #{pre_type}{\n"
        else 
            head_str = "typedef union {\n"
        end
        end_str  = "} #{name.to_s};\n"

        mstr = String.new(head_str+str+end_str)
        mstr.define_singleton_method("inst") do 
            self 
        end
        sdlm.Logic_collect << mstr

        # 获取 结构体内的变量
        all_collect = []
        SdlModule.class_variable_get('@@ele_array').each do |e|
            head_str = e.to_s 
            all_collect = all_collect + tmp_sm.send("#{head_str}_collect")
        end

        return all_collect

    end

    class DefStruct 
        attr_accessor :pre_type,:sdlm

        def initialize(sdlm,block)
            @sdlm = sdlm
            @block = block
        end

        def -(name)
            all_var_collect = ClassHDL.Struct(name,@sdlm,@pre_type,&@block)
            ## 给sdl_module 定义引用
            if @sdlm.respond_to? name 
                raise TdlError.new(" Can't define struct in module<#{@sdlm.module_name}>,because #{name} be uesed")
            end

            smeta = StructMeta.new(name,@sdlm,all_var_collect)
            @sdlm.define_singleton_method(name) do 
                smeta
            end
            ##
            _vc = @sdlm.instance_variable_get("@_struct_meta_collect_") || []
            # @sdlm.instance_variable_set("@_struct_meta_collect_",[]) unless _vc
            _vc.push smeta

            @sdlm.instance_variable_set("@_struct_meta_collect_",_vc)

            return nil
            # all_collect 
        end

        def union(&block)
            @pre_type = 'union'
            @block = block
            self
        end

        def packed(&block)
            @pre_type = 'packed'
            @block = block
            self
        end

        def method_missing(method,*args,&block)
            @block = block
            self-(method)
        end
    end

    class StructMeta
        attr_reader :name,:struct_slots
        attr_accessor :sdlm
        def initialize(name,sdlm,all_var_collect)
            @name = name
            @sdlm = sdlm 
            @struct_slots = all_var_collect
            @tmp_dimension = []
        end

        def -(varname)
            rel = StructVar.new(varname,self)
            rel.belong_to_module = @sdlm
            rel.dimension = @tmp_dimension
            @sdlm.Logic_collect << rel
            # rel.belong_to_module = @sdlm

            ## 给 sdlmodule 定义 方法

            @sdlm.define_singleton_method(varname) do
                rel 
            end
            @tmp_dimension = []
            return rel 
        end

        def method_missing(method,*args,&block) 
            self - method
        end

        def [](*args)
            @tmp_dimension += args
            return self
        end


    end

    class StructVar 
        # include ClassHDL::AssignDefOpertor
        attr_accessor :belong_to_module
        attr_accessor :dimension
        def initialize(name,meta)
            @name = name 
            @meta = meta 
            define_child_vars
            @dimension = []
        end

        def _inst_dimension
            return '' if @dimension.empty?
            str = @dimension.map do |e|
                "[#{e.to_s}-1:0]"
            end.join('')

            " #{str}"
        end

        def inst 
            "#{@meta.name} #{@name}#{_inst_dimension};".to_nq
        end

        def [](a)
            if dimension
                return TdlSpace::ArrayChain.new(self,[a])
            else  
                raise TdlError.new "#{@name} dimenson is nil "
            end
        end
        ## 定义子变量

        def define_child_vars 
            # puts @meta.struct_slots
            @meta.struct_slots.each do |e|
                self.define_singleton_method(e.name) do 
                    # RedefOpertor.with_normal_operators do
                    ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
                        TdlSpace::ArrayChain.new("#{@name}.#{e.to_s}".to_nq)
                    end
                end
            end
        end

        def to_s 
            @name.to_s
        end

        ## 添加解析包
        ## struct_var = {>>{logic var}}

    end

end



class SdlModule

    def def_struct(&block)
        return ClassHDL::DefStruct.new(self,block)
    end

end

'''
def_struct do 
    logic[31].op
    logic[3].tp
end - "s_RegInf"

s_RegInf - "s0"
s_RegInf.s2 
'''