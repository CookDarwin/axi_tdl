TdlBuild.sub_md0(__dir__) do 
    port.axis.slaver        - 'axis_in'
    input                   - 'enable'

    axis_in.clock_reset_taps('clock','rst_n')
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
    # cnt.create_tp('count test point')   - 'tp_cnt'
    # axis_in.create_tp('test point of axis_in',__FILE__,__LINE__)    - 'tp_axis_in'
    # inter_tf.create_tp('inner test point',__FILE__,__LINE__)        - 'tp_inter_tf'
    cnt.tracked_by_dve(:logic)
    axis_in.tracked_by_dve(:interface)
    inter_tf.tracked_by_dve
end