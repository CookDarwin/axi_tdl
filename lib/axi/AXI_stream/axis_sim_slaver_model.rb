require_hdl 'data_c_sim_slaver_model.sv'
TdlBuild.axis_sim_slaver_model(__dir__) do 
    parameter.RAM_DEPTH  10000
    input               - 'load_trigger'
    input[32]           - 'total_length'
    input[512*8]        - 'mem_file' # 
    port.axis.slaver    - 'in_inf'

    data_inf_c(clock: in_inf.aclk, reset: in_inf.aresetn, dsize: "in_inf.DSIZE + in_inf.KSIZE + in_inf.USIZE + 1 + 1".to_nq) - 'in_inf_dc'

    data_c_sim_slaver_model.data_c_sim_slaver_model_inst do |h|
        h.param.RAM_DEPTH       param.RAM_DEPTH
        h.input.load_trigger        load_trigger
        h.input[32].total_length    total_length
        h.input[512*8].mem_file     mem_file
        h.port.data_inf_c.slaver.in_inf     in_inf_dc
    end 

    Assign do 
        in_inf.axis_tready  <= in_inf_dc.ready
        in_inf_dc.valid     <= in_inf.axis_tvalid

        in_inf_dc.data  <+ self.>>(in_inf.axis_tuser, in_inf.axis_tkeep, in_inf.axis_tlast, in_inf.axis_tdata)
    end

end