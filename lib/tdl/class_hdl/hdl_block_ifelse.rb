module ClassHDL

    class BlockIF
        attr_accessor :cond,:opertor_chains,:slaver
        def initialize
            @opertor_chains = []
            @cond = nil
        end

        def instance(as_type= :cond)
            if cond.is_a? ClassHDL::OpertorChain
                head_str = "if(#{cond.instance(:cond)})begin"
            else 
                head_str = "if(#{cond.to_s})begin"
            end

            sub_str = []
            opertor_chains.each do |oc|
                unless oc.is_a? BlockIF
                    unless oc.slaver
                        rel_str = ClassHDL.compact_op_ch(oc.instance(as_type))
                        sub_str.push "    #{rel_str};"
                    end
                else 
                    sub_str.push( oc.instance(as_type).gsub(/^./){ |m| "    #{m}"} )
                end
            end

            return "#{head_str}\n#{sub_str.join("\n")}\nend"

        end
    end

    class BlockELSIF < BlockIF
        def instance(as_type= :cond)
            if cond.is_a? ClassHDL::OpertorChain
                head_str = "else if(#{cond.instance(:cond)})begin"
            else 
                head_str = "else if(#{cond.to_s})begin"
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

    class BlockELSE < BlockIF
        def instance(as_type= :cond)
           
            head_str = "else begin"

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

    class BlockCASE < BlockIF
        def instance(as_type= :cond)
            if cond.is_a? ClassHDL::OpertorChain
                head_str = "case(#{cond.instance(:cond)}) "
            else 
                head_str = "case(#{cond.to_s}) "
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

            return "#{head_str}\n#{sub_str.join("\n")}\nendcase"

        end
    end

    class BlockCASEX < BlockIF
        def instance(as_type= :cond)
            if cond.is_a? ClassHDL::OpertorChain
                head_str = "casex(#{cond.instance(:cond)}) "
            else 
                head_str = "casex(#{cond.to_s}) "
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

            return "#{head_str}\n#{sub_str.join("\n")}\nendcase"

        end
    end

    class BlockCASEDEFAULT < BlockIF
        def instance(as_type= :cond)
            
            head_str = "default:begin "

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

    class BlockCASEWHEN < BlockIF

        def cond_to_hdl
            if @cond.is_a? Array
                csl = @cond.compact
            else
                csl = [@cond].compact
            end 
            return csl.map{|e| e.to_s }.join(",")
        end
        def instance(as_type= :cond)
            if cond.is_a? ClassHDL::OpertorChain
                head_str = "#{cond.instance(:cond)}:begin "
            else 
                head_str = "#{cond_to_hdl}:begin "
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

module ClassHDL
    class EnumStruct
        # attr_accessor :sdl_m
        attr_accessor :belong_to_module
        def initialize(sdl_m,*args)
            args.each do |e|
                unless e.is_a? String 
                    raise TdlError.new("Enum Def element[#{e}] must be String")
                end 

                define_singleton_method(e) do |&block|
                    unless block_given?
                        e.to_nq
                    else
                        WHEN(e.to_nq,&block) 
                    end
                end
            end
            @args = args
            @sdl_m = sdl_m
            @belong_to_module = sdl_m
            # @name = name
            
        end

        def cstate
            "CSTATE_#{@name}".to_nq
        end

        def nstate
            "NSTATE_#{@name}".to_nq
        end

        alias_method :N,:nstate
        alias_method :C,:cstate

        def enum_inst(name,*args)
            str = "typedef enum { \n#{args.map{|e| "    #{e}" }.join(",\n")}\n} SE_STATE_#{name};\nSE_STATE_#{name} CSTATE_#{name},NSTATE_#{name};\n"
        end

        def typedef_name
            "SE_STATE_#{@name}".to_nq
        end

        def -(defname)
            @name = defname.to_s
            @sdl_m.Logic_inst.push(enum_inst(defname.to_s,*@args))
            _self = self
            @sdl_m.define_singleton_method(defname.to_s) do 
                _self 
            end
            self
        end
    end
end

class SdlModule

    def IF(cond,&block)
        new_op = ClassHDL::BlockIF.new
        # if ClassHDL::AssignDefOpertor.curr_assign_block.is_a? ClassHDL::BlockIF
        #     new_op.slaver = true
        # end
        ClassHDL::AssignDefOpertor.with_new_assign_block(new_op) do |ab|
            if cond.is_a? ClassHDL::OpertorChain
                cond.slaver = true
            end
            ab.cond = cond
            block.call

        end
        ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(new_op)
        return new_op
    end

    def ELSIF(cond,&block)
        new_op = ClassHDL::BlockELSIF.new
        # if ClassHDL::AssignDefOpertor.curr_assign_block.is_a? ClassHDL::BlockIF
        #     new_op.slaver = true
        # end
        ClassHDL::AssignDefOpertor.with_new_assign_block(new_op) do |ab|
            if cond.is_a? ClassHDL::OpertorChain
                cond.slaver = true
            end
            ab.cond = cond
            block.call

        end
        ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(new_op)
        return new_op
    end

    def ELSE(&block)
        new_op = ClassHDL::BlockELSE.new
        # if ClassHDL::AssignDefOpertor.curr_assign_block.is_a? ClassHDL::BlockIF
        #     new_op.slaver = true
        # end
        ClassHDL::AssignDefOpertor.with_new_assign_block(new_op) do |ab|
            block.call
        end
        ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(new_op)
        return new_op
    end

    def CASE(cond,&block)
        new_op = ClassHDL::BlockCASE.new
        # if ClassHDL::AssignDefOpertor.curr_assign_block.is_a? ClassHDL::BlockIF
        #     new_op.slaver = true
        # end
        ClassHDL::AssignDefOpertor.with_new_assign_block(new_op) do |ab|
            if cond.is_a? ClassHDL::OpertorChain
                cond.slaver = true
            end
            ab.cond = cond
            block.call

        end
        ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(new_op)
        return new_op
    end

    def CASEX(cond,&block)
        new_op = ClassHDL::BlockCASEX.new
        # if ClassHDL::AssignDefOpertor.curr_assign_block.is_a? ClassHDL::BlockIF
        #     new_op.slaver = true
        # end
        ClassHDL::AssignDefOpertor.with_new_assign_block(new_op) do |ab|
            if cond.is_a? ClassHDL::OpertorChain
                cond.slaver = true
            end
            ab.cond = cond
            block.call

        end
        ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(new_op)
        return new_op
    end

    def WHEN(*cond,&block)
        new_op = ClassHDL::BlockCASEWHEN.new

        ClassHDL::AssignDefOpertor.with_new_assign_block(new_op) do |ab|
            if cond.is_a? ClassHDL::OpertorChain
                cond.slaver = true
            end
            ab.cond = cond
            block.call

        end
        ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(new_op)
        return new_op
    end

    def DEFAULT(&block)
        new_op = ClassHDL::BlockCASEDEFAULT.new

        ClassHDL::AssignDefOpertor.with_new_assign_block(new_op) do |ab|
            block.call
        end
        ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(new_op)
        return new_op
    end

    ## 定义状态机
    def enum(*args)
        return ClassHDL::EnumStruct.new(self,*args)
    end
end