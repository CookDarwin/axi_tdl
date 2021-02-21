TdlBuild.sub_md1(__dir__) do 
    port.axis.master        - 'axis_out'
    output.logic            - 'enable'

    axis_out.clock_reset_taps('clock','rst_n')
    logic[10]                - 'cnt'
    
    data_inf_c(clock: clock, reset: rst_n, dsize: 8)    - 'inter_tf'

    always_ff(posedge.clock, negedge.rst_n) do 
        IF ~rst_n do 
            cnt     <= 0.A 
        end
        ELSE do 
            cnt     <= cnt + 1.b1 
        end
    end

    ## CREATE TEST POINT
    cnt.create_tp('count test point',__FILE__,__LINE__)   - 'tp_cnt'
    axis_out.create_tp('test point of axis_out',__FILE__,__LINE__)    - 'tp_axis_out'
    inter_tf.create_tp('inner test point',__FILE__,__LINE__)        - 'tp_inter_tf'
    enable.create_tp('enable driver',__FILE__,__LINE__) - 'enable_tp'

end