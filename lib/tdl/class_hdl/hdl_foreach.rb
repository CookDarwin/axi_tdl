module ClassHDL

    class BlockFOREACH < BlockELSE
        attr_accessor :flag
        def instance(as_type= :cond)
           
            head_str = "foreach(#{cond.to_s}[#{flag}])begin"

            sub_str = []
            opertor_chains.each do |oc|
                unless oc.is_a? BlockIF
                    unless oc.slaver
                        sub_str.push "    #{oc.instance(as_type)};"
                    end
                else 
                    sub_str.push( oc.instance(as_type).gsub(/^./){ |m| "    #{m}"} )
                end
            end

            return "#{head_str}\n#{sub_str.join("\n")}\nend"

        end
    end

    class BlockFOR < BlockELSE
        attr_accessor :flag,:var,:start,:stop,:step,:var_type
        def instance(as_type= :cond)
            
            unless var
                head_str = "for(#{var_type} #{flag}=#{start};#{flag}<#{stop};#{flag}=#{flag}+#{step})begin"
            else
                head_str = "for(#{var}=#{start};#{flag}<#{stop};#{flag}=#{flag}+#{step})begin"
            end

            sub_str = []
            opertor_chains.each do |oc|
                unless oc.is_a? BlockIF
                    unless oc.slaver
                        sub_str.push "    #{oc.instance(as_type)};"
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
    @@__foreach_index_cnt__ = 0
    def FOREACH(cond,&block)
        ClassHDL::AssignDefOpertor.with_normal_opertor do 
            @@__foreach_index_cnt__ += 1
        end
        new_op = ClassHDL::BlockFOREACH.new

        ClassHDL::AssignDefOpertor.with_new_opertor do 
            ClassHDL::AssignDefOpertor.with_new_assign_block(new_op) do |ab|
                if cond.is_a? ClassHDL::OpertorChain
                    cond.slaver = true
                end
                ab.cond = cond
                ab.flag = "i#{@@__foreach_index_cnt__}".to_nq
                block.call(ab.flag)

            end
        end 
        
        ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(new_op)
        ClassHDL::AssignDefOpertor.with_normal_opertor do 
            @@__foreach_index_cnt__ -= 1
        end
        return new_op
    end

    @@__for_index_cnt__ = 0
    def FOR(var: nil, start: 0, stop: 8, step: 1,&block)
        ClassHDL::AssignDefOpertor.with_normal_opertor do 
            @@__for_index_cnt__ += 1
        end
        new_op = ClassHDL::BlockFOR.new

        ClassHDL::AssignDefOpertor.with_new_opertor do 
            ClassHDL::AssignDefOpertor.with_new_assign_block(new_op) do |ab|
                # if cond.is_a? ClassHDL::OpertorChain
                #     cond.slaver = true
                # end
                # ab.cond = cond
                ab.var = var
                ab.start = start 
                ab.stop = stop 
                ab.step = step
                ab.flag = var || "gvar_cc_#{@@__for_index_cnt__}".to_nq
                block.call(ab.flag)

            end
        end 

        if ClassHDL::AssignDefOpertor.curr_assign_block.is_a?(ClassHDL::GenerateBlock)
            new_op.var_type = "genvar"
        else
            new_op.var_type = "integer"
        end
    
        ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(new_op)
        ClassHDL::AssignDefOpertor.with_normal_opertor do 
            @@__for_index_cnt__ -= 1
        end
        return new_op
    end
end