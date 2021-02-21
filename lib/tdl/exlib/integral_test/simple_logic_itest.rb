# require_relative 'integral_test'
class SimpleLogicITest < IntegralTest

    def initialize(pin_key:"",dsize:1,dimension:[],type:"logic")
        @pin_key = pin_key.to_s.downcase
        @dsize = dsize
        @dimension = dimension
        @type = type
    end


    def tb_top_connect_element
        tbc = TBConnnectEle.new(type:Logic)
        tbc.baseelm_argv = {name:@pin_key,dsize:@dsize,dimension:@dimension,type:@type}
        tbc.port_key = @pin_key.to_sym
        tbc
    end

end
