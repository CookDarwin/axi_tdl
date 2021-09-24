module ClassHDL

    class HDLAssignGenerateBlock  

        attr_accessor :opertor_chains
        attr_reader :belong_to_module
        def initialize(belong_to_module)
            @opertor_chains = []
            @belong_to_module = belong_to_module
        end

        def instance

        end

    end

    class GenerateBlock <  ClearSdlModule
        attr_accessor :block_index
        def initialize(belong_to_module)
            @belong_to_module = belong_to_module
            super("genblk#{belong_to_module._auto_name_incr_index_}")
            unless @belong_to_module
                raise TdlError.new("GenerateBlock must have belong_to_module")
            end
        end


        def method_missing(name,*args,&block)
            ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
                ## 优先判断 belong_to_module 有没有定义此方法 
                if root_sdlmodule.respond_to? name 
                    root_sdlmodule.send(name,*args,&block)
                elsif SdlModule.exist_module?(name)
                # puts root_sdlmodule
                # if SdlModule.exist_module?(name)
                    ClassHDL::ImplicitInstModule.new(name,self)
                else
                    @belong_to_module.send(name,*args,&block)
                end
            end
        end

        def IF(cond,&block)
            if ClassHDL::AssignDefOpertor.curr_assign_block.is_a? HDLAssignGenerateBlock
                if cond.respond_to?(:instance)
                    head_str = "\nif(#{cond.instance(:cond, @belong_to_module)})begin\n"
                else 
                    head_str = "\nif(#{cond})begin\n"
                end
                # yield
                tmp_sm = ClearGenerateSlaverBlock.new(self)

                tmp_sm.module_name = "generate_sub_block_#{self.block_index}"
                inst_obj = tmp_sm.instanced("genblk#{self.block_index}",tmp_sm)
                inst_obj.belong_to_module = tmp_sm
                add_children_modules(inst_obj:inst_obj ,module_poit: tmp_sm)

                tmp_sm.instance_exec(&block)
                ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
                    body_str = tmp_sm.instance_draw + tmp_sm.vars_exec_inst
                    gbody_str = body_str.gsub(/^./){ |m| "    #{m}"}
                    self.Logic_inst.push(head_str+gbody_str+"end ")
                end
            else 
                super(cond,&block)
            end
        end

        def ELSIF(cond,&block)
            if ClassHDL::AssignDefOpertor.curr_assign_block.is_a? HDLAssignGenerateBlock
                if cond.respond_to?(:instance)
                    head_str = "else if(#{cond.instance(:cond,@belong_to_module)})begin\n"
                else 
                    head_str = "else if(#{cond})begin\n"
                end
                # yield
                tmp_sm = ClearGenerateSlaverBlock.new(self)
                tmp_sm.module_name = "generate_sub_block_#{self.block_index}"
                inst_obj = tmp_sm.instanced("genblk#{self.block_index}",tmp_sm)
                inst_obj.belong_to_module = tmp_sm
                add_children_modules(inst_obj:inst_obj ,module_poit: tmp_sm)

                tmp_sm.instance_exec(&block)
                ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
                    body_str = tmp_sm.instance_draw + tmp_sm.vars_exec_inst
                    gbody_str = body_str.gsub(/^./){ |m| "    #{m}"}
                    self.Logic_inst.push(head_str+gbody_str+"end\n")
                end
            else 
                super(cond,&block)
            end
        end

        def ELSE(&block)
            if ClassHDL::AssignDefOpertor.curr_assign_block.is_a? HDLAssignGenerateBlock
                head_str = "else begin\n"
                # yield
                tmp_sm = ClearGenerateSlaverBlock.new(self)
                tmp_sm.module_name = "generate_sub_block_#{self.block_index}"
                inst_obj = tmp_sm.instanced("genblk#{self.block_index}",tmp_sm)
                inst_obj.belong_to_module = tmp_sm
                add_children_modules(inst_obj:inst_obj ,module_poit: tmp_sm)

                tmp_sm.instance_exec(&block)
                ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
                    body_str = tmp_sm.instance_draw + tmp_sm.vars_exec_inst
                    gbody_str = body_str.gsub(/^./){ |m| "    #{m}"}
                    self.Logic_inst.push(head_str+gbody_str+"end\n")
                end
            else 
                super(&block)
            end
        end
    end 

    class ClearGenerateSlaverBlock < ClearSdlModule
        def initialize(belong_to_module)
            @belong_to_module = belong_to_module
            # @dont_gen_sv = true
            super("slavergenblk#{rand(1024)}")
        end

        def method_missing(name,*args,&block)
            ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
                # puts name
                # puts SdlModule.exist_module?(name)
                # puts @belong_to_module.module_name
                # puts @belong_to_module.respond_to?(name) 
                ## 优先判断 belong_to_module 有没有定义此方法 
                if root_sdlmodule.respond_to? name 
                    root_sdlmodule.send(name,*args,&block)
                elsif SdlModule.exist_module?(name)
                # if SdlModule.exist_module?(name)
                    ClassHDL::ImplicitInstModule.new(name,self)
                else
                    @belong_to_module.send(name,*args,&block)
                end

            end
        end
    end
end

class SdlModule

    def generate(*args,&block)
        head_str = ""
        index = 0
        @__generate_blocks__ ||= []
        tmp_sm = ClassHDL::GenerateBlock.new(self)
        kk_args = []
        @__generate_blocks__ << tmp_sm
        tmp_sm.block_index = @__generate_blocks__.size

        tmp_sm.module_name = "generate_block_#{tmp_sm.block_index}"
        if args.empty? 
            inst_obj = tmp_sm.instanced("genblk#{tmp_sm.block_index}",tmp_sm)
        else 
            inst_obj = tmp_sm.instanced("genblk#{tmp_sm.block_index}[0]",tmp_sm) ## 只取第一个
        end
        inst_obj.belong_to_module = tmp_sm

        add_children_modules(inst_obj:inst_obj ,module_poit: tmp_sm)

        args.each_index do |e|
            new_op = ClassHDL::OpertorChain.new(nil, self) 
            new_op.tree.push(["KK#{e}".to_nq])
            kk_args << new_op
        end
        ClassHDL::AssignDefOpertor.with_new_assign_block(ClassHDL::HDLAssignGenerateBlock.new(self) ) do 
            ClassHDL::AssignDefOpertor.with_rollback_opertors(:new) do 
                tmp_sm.instance_exec(*kk_args,&block)
            end
        end

        str = (tmp_sm.instance_draw + tmp_sm.vars_exec_inst)

        gstr = generate_block_inst_iterate(str,args)
        head_str = "generate\n"
        end_str  = "endgenerate\n"
        self.Logic_inst << head_str+gstr+end_str
    end

    private 

    def generate_block_inst_iterate(body_str,args)
        index = args.size-1
        bstr = body_str
        args.reverse.each do |arg|
            bstr = generate_block_inst(arg,index=index,bstr)
            index -= 1
        end

        return bstr
    end

    def generate_block_inst(arg=[0,8],index=0,body_str="")
        if arg.respond_to?(:first) && arg.respond_to?(:last)
            start = arg.first
            stop = arg.last 
        else 
            start = 0
            stop = arg
        end

        if start.is_a?(Integer) && stop.is_a?(Integer)
            if start < stop 
                flag = "<"
            else 
                flag = ">"
            end 
        else 
            flag = "<"
        end

        head_str = "for(genvar KK#{index}=#{start};KK#{index} #{flag} #{stop};KK#{index}#{flag=="<" ? '++' : '--'})begin\n"
        gbody_str = body_str.gsub(/^./){ |m| "    #{m}"}

        return head_str+gbody_str+"end\n"
    end
end