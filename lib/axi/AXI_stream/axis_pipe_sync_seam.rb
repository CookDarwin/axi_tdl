require_sdl 'data_c_pipe_sync_seam.rb'

TdlBuild.axis_pipe_sync_seam(__dir__) do 
    parameter.LAT       4
    parameter.DSIZE     32
        ## as like: hdl``` 
    ## assign in_datas[0] = in_inf.axis_tdata + 1;
    ## assign in_datas[1] = out_datas[0]+1;```
    input[param.LAT,param.DSIZE]    - 'in_datas'    
    output[param.LAT,param.DSIZE]   - 'out_datas'
    port.axis.slaver                - 'in_inf'
    port.axis.master                - 'out_inf'

    data_inf_c(clock: in_inf.aclk, reset: in_inf.aresetn, dsize: "in_inf.DSIZE+in_inf.KSIZE+1+in_inf.USIZE".to_nq) - 'data_in_inf'
    data_in_inf.copy(name: 'data_out_inf')

    data_c_pipe_sync_seam.data_c_pipe_sync_seam_inst do |h|
        h.parameter.LAT       param.LAT
        h.parameter.DSIZE     param.DSIZE
        ## as like: hdl``` 
        ## assign in_datas[0] = in_inf.data + 1;
        ## assign in_datas[1] = out_datas[0]+1;```
        h.input[h.param.LAT,h.param.DSIZE].in_datas         in_datas
        h.output[h.param.LAT,h.param.DSIZE].out_datas       out_datas
        h.port.data_inf_c.slaver.in_inf                     data_in_inf
        h.port.data_inf_c.master.out_inf                    data_out_inf
    end

    Assign do 
        data_in_inf.data    <= self.>>(in_inf.axis_tuser, in_inf.axis_tkeep, in_inf.axis_tlast, in_inf.axis_tdata)
        data_in_inf.valid   <= in_inf.axis_tvalid 
        in_inf.axis_tready  <= data_in_inf.ready 


        logic_bind_(out_inf.axis_tuser, out_inf.axis_tkeep, out_inf.axis_tlast, out_inf.axis_tdata) <= data_out_inf.data 
        out_inf.axis_tvalid     <= data_out_inf.valid 
        data_out_inf.ready      <= out_inf.axis_tready

    end

end