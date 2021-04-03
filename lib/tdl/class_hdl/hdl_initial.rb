module ClassHDL


    class HDLInitialBlock 
        attr_accessor :opertor_chains
        attr_reader :belong_to_module
        def initialize(belong_to_module)
            @opertor_chains = []
            @belong_to_module = belong_to_module
            unless @belong_to_module 
                raise TdlError.new("HDLInitialBlock must have belong_to_module")
            end
        end

        def instance(block_name=nil)
            str = []
            str.push "initial begin#{block_name ? ':'.concat(block_name.to_s) : ''}"
            opertor_chains.each do |op|
                unless op.is_a? OpertorChain
                    str.push op.instance(:assign).gsub(/^./){ |m| "    #{m}"}
                else 
                    unless op.slaver
                        rel_str = ClassHDL.compact_op_ch(op.instance(:assign, belong_to_module))
                        str.push "    #{rel_str};"
                    end
                end
                
            end
            str.push "end\n"
            str.join("\n")
        end

        def instance_inspect()
            str = []
            block_name=nil
            str.push "initial begin#{block_name ? ':'.concat(block_name.to_s) : ''}"
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
            str.push "end\n"
            str.join("\n")
        end
    end

    def self.Initial(sdl_m,block_name=nil,&block)
        ClassHDL::AssignDefOpertor.with_new_assign_block(ClassHDL::HDLInitialBlock.new(sdl_m)) do |ab|
            AssignDefOpertor.with_rollback_opertors(:new,&block)
            # return ClassHDL::AssignDefOpertor.curr_assign_block
            AssignDefOpertor.with_rollback_opertors(:old) do
                sdl_m.Logic_draw.push ab.instance(block_name)
            end
        end
    end

    class BlocAssertIF < BlockIF
        def instance(as_type= :cond)
            if cond.is_a? ClassHDL::OpertorChain
                head_str = "assert(#{cond.instance(:cond, belong_to_module)})else begin"
            else 
                head_str = "assert(#{cond.to_s})else begin"
            end

            sub_str = []
            opertor_chains.each do |oc|
                unless oc.is_a? BlockIF
                    unless oc.slaver
                        sub_str.push "    #{oc.instance(as_type,belong_to_module)};"
                    end
                else 
                    sub_str.push( oc.instance(as_type).gsub(/^./){ |m| "    #{m}"} )
                end
            end

            return "#{head_str}\n#{sub_str.join("\n")}\nend"

        end
    end
end



class SdlModule

    def Initial(block_name=nil,&block)
        ClassHDL::Initial(self,block_name,&block)
    end

    def initial(block_name=nil,&block)
        ClassHDL::Initial(self,block_name,&block)
    end

    def assert(cond,formats=false,*argsx,&block)
        unless formats
            return assert_old(cond,nil,&block)    
        end
        if formats.is_a?(String) && argsx.empty? 
            return assert_old(cond,argv_str=formats,&block)
        end

        new_op = ClassHDL::BlocAssertIF.new(self)
        ClassHDL::AssignDefOpertor.with_new_assign_block(new_op) do |ab|
            if cond.is_a? ClassHDL::OpertorChain
                cond.slaver = true
            end
            ab.cond = cond
            if block_given?
                block.call
            else 
                assert_format_error([formats],argsx)
            end

        end
        ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(new_op)
        
        return new_op

    end

    def assert_old(cond,argv_str=nil,&block)
        new_op = ClassHDL::BlocAssertIF.new(self)
        # if ClassHDL::AssignDefOpertor.curr_assign_block.is_a? ClassHDL::BlockIF
        #     new_op.slaver = true
        # end
        ClassHDL::AssignDefOpertor.with_new_assign_block(new_op) do |ab|
            if cond.is_a? ClassHDL::OpertorChain
                cond.slaver = true
            end
            ab.cond = cond
            if block_given?
                block.call
            else 
                if argv_str  
                    assert_error(argv_str)
                end
            end

        end
        ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(new_op)

        # unless argv_str
        #     assert_error(argv_str)
        # end
        
        return new_op
    end

    def assert_error(argv_str)
        ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(ClassHDL::OpertorChain.new(["$error(\"#{argv_str}\")".to_nq], self))
        ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(ClassHDL::OpertorChain.new(["$stop".to_nq], self))
    end

    def assert_format_error(formats=[],args=[])
        ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(ClassHDL::OpertorChain.new(["$error(\"#{formats.join(' ')}\",#{args.map{|s| s.to_s}.join(',')})".to_nq], self))
        ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(ClassHDL::OpertorChain.new(["$stop".to_nq], self))
    end

    def initial_exec(str)
        ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(ClassHDL::OpertorChain.new([str.to_s.to_nq], self))
    end

    alias_method :always_sim_exec, :initial_exec
end