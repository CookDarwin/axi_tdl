# require_relative 'integral_test'
class IOITest < IntegralTest

    def initialize(pin_key:"",dimension:[],dsize:1,&block)
        @pin_key = pin_key.to_s.downcase
        @dsize = dsize
        @dimension = dimension
        @pin_name = GlobalParam.CurrTdlModule.create_logic_port(name:@pin_key,dsize:@dsize,port:"output logic",dimension:@dimension)
        @str_stack = []
        yield(self)
        inst
    end

    def inst
        Tdl.after_dynamict_inst_stack << lambda {
"
initial begin:#{@pin_key}_BLOCK
    #{
    @str_stack.join(";\n    ")
};
end
"
        }
    end

    def tb_top_connect_element
        tbc = TBConnnectEle.new(type:Logic)
        tbc.baseelm_argv = {name:@pin_key,dsize:@dsize,dimension:@dimension}
        tbc.port_key = @pin_key.to_sym
        tbc
    end

    def exec(str)
        @str_stack << str.to_s
    end

    def assign(value)
        @str_stack << "#{@pin_name.signal} = #{value.to_s}"
    end

end
