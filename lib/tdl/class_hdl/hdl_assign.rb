module ClassHDL


    class HDLAssignBlock 
        attr_accessor :opertor_chains
        attr_reader :belong_to_module
        
        def initialize(belong_to_module)
            @opertor_chains = []
            @belong_to_module = belong_to_module
            unless @belong_to_module 
                raise TdlError.new("HDLAssignBlock must have belong_to_module")
            end
        end

        def instance
            unless @belong_to_module.is_a?(SdlModule) 
                raise TdlError.new("HDLAssignBlock must have belong_to_module")
            end
            str = []
            opertor_chains.each do |op|
                
                unless op.slaver
                    sub_str = op.instance(:assign,belong_to_module)
                    # if sub_str =~ /^(?<head>[\w\.\[\]\:]+\s*)(?<eq><?=\s*)\((?<body>.+)\)$/
                    #     rel_str = $~[:head] + $~[:eq] + $~[:body]
                    # else 
                    #     rel_str = sub_str
                    # end
                    rel_str = ClassHDL.compact_op_ch(sub_str)
                    str << "assign " + rel_str + ";\n"
                end
            end
            str.join("")
        end
    end

    def self.Assign(sdl_m,&block)
        # ClassHDL::AssignDefOpertor.curr_assign_block = ClassHDL::HDLAssignBlock.new
        ClassHDL::AssignDefOpertor.with_new_assign_block(ClassHDL::HDLAssignBlock.new(sdl_m)) do |ab|
            AssignDefOpertor.with_rollback_opertors(:new,&block)
            # return ClassHDL::AssignDefOpertor.curr_assign_block
            AssignDefOpertor.with_rollback_opertors(:old) do 
                sdl_m.Logic_draw.push ClassHDL::AssignDefOpertor.curr_assign_block.instance
            end
        end
    end
end



class SdlModule

    def Assign(&block)
        ClassHDL::Assign(self,&block)
    end
end