# require_relative 'integral_test'

class DiffClockITest < IntegralTest

    def initialize(pin_key:"",freqM:100,pin_key_n:"")
        @pin_key = pin_key.to_s.downcase
        @pin_key_n = pin_key_n.to_s.downcase
        @freqM = freqM
        @pin_name = GlobalParam.CurrTdlModule.create_port_clock(name:pin_key,port: :output,freqM:freqM)
        inst
    end

    def inst
        Tdl.inst_clock_rst_verb(
            rst_hold:50,
            freqm:  @freqM,
            clock:  @pin_name,
            rst_x:  "")
    end

    def tb_top_connect_element
        # [Clock,{name:@pin_key,freqM:@freqM}]
        tbc = TBConnnectEle.new(type:Clock)
        tbc.baseelm_argv = {name:@pin_key,freqM:@freqM}
        tbc.port_key = @pin_key.to_sym
        tbc.port_key_n = @pin_key_n.to_sym
        tbc
    end

end
