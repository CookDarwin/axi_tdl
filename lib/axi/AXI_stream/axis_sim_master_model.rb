require_hdl 'data_c_sim_master_model.sv'

TdlBuild.axis_sim_master_model(__dir__) do 
    parameter.LOOP       "TRUE"
    parameter.RAM_DEPTH  10000
    input               - 'enable'
    input               - 'load_trigger'
    input[32]           - 'total_length'
    input[512*8]        - 'mem_file' # {axis_tvalid, axis_tuser, axis_tkeep, axis_tlast, axis_tdata}
    port.axis.master    - 'out_inf'

    data_inf_c(clock: out_inf.aclk, reset: out_inf.aresetn, dsize: "out_inf.DSIZE + out_inf.KSIZE + out_inf.USIZE + 1".to_nq) - 'out_inf_dc'

    data_c_sim_master_model.data_c_sim_master_model_inst do |h| #(
        h.param.LOOP        param.LOOP
        h.param.RAM_DEPTH   param.RAM_DEPTH
        h.input.enable              enable
        h.input.load_trigger        load_trigger
        h.input[32].total_length    total_length
        h.input[512*8].mem_file     mem_file
        h.port.data_inf_c.master.out_inf    out_inf_dc
    end

    Assign do 
        out_inf.axis_tvalid <= out_inf_dc.valid 
        out_inf_dc.ready    <= out_inf.axis_tready 

        self.>>(out_inf.axis_tuser, out_inf.axis_tkeep, out_inf.axis_tlast, out_inf.axis_tdata) <= out_inf_dc.data
    end 
end
