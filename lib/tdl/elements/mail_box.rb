
class MailBox < BaseElm

    # include AlwaysBlock
    # include RedefOpertor
    attr_accessor :ghost
    def initialize(name:'mbox',depth:100)
        @name = name

        @depth = depth

    end

    def signal
        "#{@name}"
    end

    def to_s
        signal
    end

    def inst
        "mailbox #{@name} = new(#{@depth});\n"
    end

    # def _assign_small_and_eq(b)
    #     $__tdl_cur_always_env__.assign_proc(self,b)
    # end

    def put(baseelm)
        b = "#{signal}.put(#{exp_element(baseelm)})"
        $__curr_logic_for_expect.last.assign_proc(nil,b)
        return nil
    end

    def get(baseelm)
        b = "#{signal}.get(#{exp_element(baseelm)})"
        $__curr_logic_for_expect.last.assign_proc(nil,b)
        return nil
    end

    # redefine cond_block_proc
    def cond_block_proc(a,b=nil)
        unless a.eql? self
            super(a,b)
        else
            if(b.is_a? Hash)
                if b[:cond_type].eql? :if_exp
                    exp_element(b[:cond_value])
                end
            elsif b.nil?
                rel = exp_element(a)
                if rel =~ /\s+end\s*$/
                    rel
                else
                    rel.concat(";")
                end
            else
                exp_element(a).concat(".put(").concat(exp_element(b)).concat(");")
            end
        end
    end

end
