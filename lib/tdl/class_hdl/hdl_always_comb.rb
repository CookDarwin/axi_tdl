module ClassHDL


    class HDLAlwaysCombBlock 
        attr_accessor :opertor_chains
        attr_reader :belong_to_module
        def initialize(belong_to_module)
            @opertor_chains = []
            @belong_to_module = belong_to_module
            unless @belong_to_module
                raise TdlError.new("HDLAlwaysCombBlock must have belong_to_module")
            end
        end

        def instance
            str = []
            str.push "always_comb begin "
            opertor_chains.each do |op|
                unless op.is_a? OpertorChain
                    str.push op.instance(:assign).gsub(/^./){ |m| "    #{m}"}
                else 
                    unless op.slaver
                        rel_str = ClassHDL.compact_op_ch(op.instance(:assign, @belong_to_module))
                        str.push "    #{rel_str};"
                    end
                end
                
            end
            str.push "end\n"
            str.join("\n")
        end
    end

    def self.AlwaysComb(sdl_m,&block)
        ClassHDL::AssignDefOpertor.with_new_assign_block(ClassHDL::HDLAlwaysCombBlock.new(sdl_m)) do |ab|
            AssignDefOpertor.with_rollback_opertors(:new,&block)
            # return ClassHDL::AssignDefOpertor.curr_assign_block
            AssignDefOpertor.with_rollback_opertors(:old) do
                sdl_m.Logic_draw.push ab.instance
            end
        end
    end
end



class SdlModule

    def AlwaysComb(&block)
        ClassHDL::AlwaysComb(self,&block)
    end

    def Always_comb(&block)
        ClassHDL::AlwaysComb(self,&block)
    end

    alias_method :always_comb,'Always_comb'
end