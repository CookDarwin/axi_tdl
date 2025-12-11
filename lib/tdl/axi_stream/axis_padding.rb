TdlBuild.axis_padding(__dir__) do 
    parameter.NUM       8
    port.axis.slaver     - 'axis_in'
    port.axis.master     - 'axis_out'

    axis_in.clock_reset_taps('clock','rst_n')

    logic       - 'padding'
    logic[clog2(param.NUM+1)]    - 'pad_cnt'

    always_ff(posedge: clock) do 
        IF ~rst_n do 
            padding     <= 1.b0
            pad_cnt     <= 0.A 
        end
        ELSE do 
            IF axis_in.vld_rdy_last do 
                padding     <= 1.b1 
            end
            ELSE do 
                padding     <= pad_cnt  > 0.A 
            end

            IF axis_in.vld_rdy_last do 
                pad_cnt     <= param.NUM
            end
            ELSE do 
                IF pad_cnt  > 0.A do 
                    pad_cnt <= pad_cnt - 1.b1 
                end
                ELSE do 
                    pad_cnt <= 0.A 
                end
            end
        end
    end

    axis_valve.axis_valve_inst do |h| 
        h.input.button                  ~padding #          //[1] OPEN ; [0] CLOSE
        h.port.axis.slaver.axis_in      axis_in
        h.port.axis.master.axis_out     axis_out
    end 

end