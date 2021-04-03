module ClassHDL

    class HDLFunctionIvoke
        include AssignDefOpertor

        def initialize(func_inst,*fargvs)
            @fargvs = fargvs
            @func_inst = func_inst
            inst_strcut_method()
        end
        ## 例化 struct 方法调用
        def inst_strcut_method
            if @func_inst.return_type.is_a? StructMeta
                @func_inst.return_type.struct_slots.each do |e|
                    self.define_singleton_method(e.name) do 
                        TdlSpace::ArrayChain.create(obj: "#{@func_inst.name}.#{e.name}".to_nq, belong_to_module: @func_inst.belong_to_module )
                    end
                end
            end
        end

        def ivoked
            str = @fargvs.map do |e| 
                if e.is_a? OpertorChain
                    e.slaver = true 
                end
                
                if e.instance_of? String
                    "\"#{e}\""
                else 
                    e.to_s 
                end
            end.join(",")

            return "#{@func_inst.name}(#{str})".to_nq
        end

        # def <=(oc)
            
        # end

        def to_s 
            if @func_inst.open_ivoke
                ivoked
            else 
                @func_inst.name.to_s.to_nq
            end
        end

        # def self_ioved 

        # end
    end


    class HDLFunction
        attr_accessor :opertor_chains,:name
        attr_accessor :open_ivoke
        attr_reader   :return_type
        attr_reader   :belong_to_module

        def initialize(belong_to_module,name,return_type,*argvs)
            @opertor_chains = []
            @name = name
            @argvs = argvs
            @return_type = return_type
            @belong_to_module = belong_to_module
        end

        def inst_port
            return @argvs.map{|e| "#{e.inst_port[0]} #{e.inst_port[1]}" }.join(',')
        end

        def instance
            str = []
            if @return_type
                if @return_type.is_a? EnumStruct
                    str.push "function #{@return_type.typedef_name} #{@name}(#{inst_port}); "
                elsif @return_type.is_a? StructMeta
                    str.push "function #{@return_type.name} #{@name}(#{inst_port}); "
                else
                    str.push "function #{@return_type.to_s} #{@name}(#{inst_port}); "
                end
            else
                str.push "function #{@name}(#{inst_port}); "
            end

            opertor_chains.each do |op|
                unless op.is_a? OpertorChain
                    str.push op.instance(:assign).gsub(/^./){ |m| "    #{m}"}
                else 
                    unless op.slaver
                        rel_str = ClassHDL.compact_op_ch(op.instance(:assign,belong_to_module))
                        str.push "    #{rel_str};"
                    end
                end
                
            end
            str.push "endfunction:#{@name}\n"
            str.join("\n")
        end

        def ivoked(*fargvs)
            str = fargvs.map do |e| 
                if e.is_a? OpertorChain
                    e.slaver = true 
                end
                
                if e.instance_of? String
                    "\"#{e}\""
                else 
                    e.to_s 
                end
            end.join(",")

            return "#{@name}(#{str})".to_nq
        end
    end

    def self.Function(sdl_m,name,return_type,*argvs,&block)
        define_func_block_method(sdl_m,*argvs)
        func_inst = ClassHDL::HDLFunction.new(sdl_m,name,return_type,*argvs)
        ## 给 sdl module 定义函数方法
        sdl_m.define_singleton_method(name) do |*fargvs|
            # new_op = OpertorChain.new 
            # new_op.tree.push([func_inst.ivoked(*fargvs)])
            # new_op.slaver= true
            # AssignDefOpertor.curr_assign_block.opertor_chains.push(new_op)
            # new_op
            fargvs.each do |e|
                if e.is_a? OpertorChain
                    e.slaver = true 
                end
            end
            
            HDLFunctionIvoke.new(func_inst,*fargvs)
        end

        ClassHDL::AssignDefOpertor.with_new_assign_block(func_inst) do |ab|

            AssignDefOpertor.with_rollback_opertors(:old) do
                argvs.each do |e|
                   
                end
            end
            AssignDefOpertor.with_rollback_opertors(:new,&block)
            # return ClassHDL::AssignDefOpertor.curr_assign_block
            AssignDefOpertor.with_rollback_opertors(:old) do
                sdl_m.Logic_draw.push ab.instance
            end
        end
        remove_func_block_method(sdl_m,*argvs)
        func_inst.open_ivoke = true
    end

    class DefFunction
        attr_accessor :return_type
        def initialize(sdlm,return_type=nil)
            @return_type = return_type
            @sdlm = sdlm
        end

        def method_missing(method,*argvs,&block)
            ClassHDL::Function(@sdlm,method,return_type,*argvs,&block)
            ClassHDL.enable_SdlModule_port
        end
    end

    ## redefine sdlmodule input output 

    def self.disable_SdlModule_port
        symbs = [:Input,:Output,:Inout]
        symbs.each do |symb|
            SdlModule.class_eval do
                alias_method "_function_bak_#{symb}__",symb
            end
        end
    end

    def self.enable_SdlModule_port
        symbs = [:Input,:Output,:Inout]
        symbs.each do |symb|
            SdlModule.class_eval do
                alias_method symb,"_function_bak_#{symb}__"
            end
        end
    end

    def self.new_def_SdlModule_port
        SdlModule.class_eval do 
            def Input(name,dsize:1,dimension:[],pin:[],iostd:[],pin_prop:nil)
                port_name_chk(name)
                # pin,iostd = parse_pin_prop(pin_prop) if pin_prop
                # RedefOpertor.with_normal_operators do
                ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
                    tmp = Logic.new(name:name,dsize:dsize,port:"input",dimension:dimension, belong_to_module: self)
                    # add_to_new_module("@port_logics",tmp)
                    # add_method_to_itgt(name,tmp)
                    tmp
                end
            end
        
            def Output(name,dsize:1,dimension:[],pin:[],iostd:[],pin_prop:nil)
                port_name_chk(name)
                # pin,iostd = parse_pin_prop(pin_prop) if pin_prop
                # RedefOpertor.with_normal_operators do
                ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
                    tmp = Logic.new(name:name,dsize:dsize,port:"output logic",dimension:dimension, belong_to_module: self)
                    # add_to_new_module("@port_logics",tmp)
        
                    if block_given?
                        yield(tmp)
                    end
                    # define_method(name) do
                    # add_method_to_itgt(name,tmp)
                    tmp
                end
            end
        
            def Inout(name,dsize:1,dimension:[],pin:[],iostd:[],pin_prop:nil)
                port_name_chk(name)
                # pin,iostd = parse_pin_prop(pin_prop) if pin_prop
                # RedefOpertor.with_normal_operators do
                ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
                    tmp = Logic.new(name:name,dsize:dsize,port:"inout",dimension:dimension)
                    # add_to_new_module("@port_logics",tmp)
        
                    if block_given?
                        yield(tmp)
                    end
                    # define_method(name) do
                    # add_method_to_itgt(name,tmp)
                    tmp
                end
            end
        end
    end

    def self.with_disable_SdlModule_port(&block)
        disable_SdlModule_port
        new_def_SdlModule_port
        rel = block.call 
        enable_SdlModule_port
        rel
    end
    ## 为 function 块内定义 argv 方法
    def self.define_func_block_method(sdlm,*argv)
        argv.each do |e|
            sdlm.define_singleton_method(e.name) do 
                e 
            end
        end
    end

    def self.remove_func_block_method(sdlm,*argv)
        argv.each do |e|
            # sdlm.define_singleton_method(e.name) do 
            #     method_missing(e.name)
            # end
            sdlm.instance_eval("undef #{e.name}")
        end
    end
end



class SdlModule

    # def _core_function(name,*argvs,&block)
    #     ClassHDL::Function(self,name,*argvs,&block)
    # end

    def function(return_type=nil)
        ClassHDL.disable_SdlModule_port
        ClassHDL.new_def_SdlModule_port
        return ClassHDL::DefFunction.new(self,return_type)
    end

end