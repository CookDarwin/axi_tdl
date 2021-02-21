# require_relative 'integral_test'
class ResetITest < IntegralTest

    def initialize(pin_key:"",active:"low",latency:"10ns")
        @pin_key = pin_key.to_s.downcase
        @active = active.to_s.downcase
        @latency = latency
        @pin_name = GlobalParam.CurrTdlModule.create_port_reset(name:@pin_key,port: "output logic",active:@active)
        inst
    end

    def inst
        Tdl.after_dynamict_inst_stack << lambda {
"
initial begin:#{@pin_key}_BLOCK
    #{@pin_name.signal} = #{(@active == "low") ? "0" : "1"};
    #(#{@latency});
    #{@pin_name.signal} = #{(@active == "low") ? "1" : "0"};
end
"
        }
    end

    def tb_top_connect_element
        tbc = TBConnnectEle.new(type:Reset)
        tbc.baseelm_argv = {name:@pin_key,active:@active}
        tbc.port_key = @pin_key.to_sym
        tbc
    end

end
