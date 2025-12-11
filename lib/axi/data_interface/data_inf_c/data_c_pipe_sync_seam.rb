require_hdl 'data_c_pipe_sync.sv'

TdlBuild.data_c_pipe_sync_seam(__dir__) do 
    parameter.LAT       4 
    parameter.DSIZE     32
    ## as like: hdl``` 
    ## assign in_datas[0] = in_inf.data + 1;
    ## assign in_datas[1] = out_datas[0]+1;```
    input[param.LAT,param.DSIZE]        - 'in_datas'    
    output[param.LAT,param.DSIZE]       - 'out_datas'
    port.data_inf_c.slaver              - 'in_inf'
    port.data_inf_c.master              - 'out_inf'

    same_clock_domain(in_inf, out_inf)

    in_inf.copy(name: 'in_inf_array', dimension: [param.LAT])
    out_inf.copy(name: 'out_inf_array', dimension: [param.LAT])

    generate(param.LAT) do |kk|
        data_c_pipe_sync.data_c_pipe_sync_inst do |h|
            h.parameter.DSIZE           param.DSIZE 
            h.input['DSIZE'].in_data    in_datas[kk]   ##// as like: hdl``` assign in_data = in_inf.data + 1;
            h.output['DSIZE'].out_data  out_datas[kk]
            h.port.data_inf_c.slaver.in_inf     in_inf_array[kk]
            h.port.data_inf_c.master.out_inf    out_inf_array[kk]
        end

        IF kk != 0 do 
            Assign do 
                in_inf_array[kk].valid     <= out_inf_array[kk-1].valid
                in_inf_array[kk].data      <= out_inf_array[kk-1].data
                out_inf_array[kk-1].ready  <= in_inf_array[kk].ready
            end     
        end
    end

    Assign do 
        in_inf_array[0].valid     <= in_inf.valid
        in_inf_array[0].data      <= in_inf.data
        in_inf.ready              <= in_inf_array[0].ready
    end

    Assign do 
        out_inf.data  <= out_inf_array[param.LAT-1].data
        out_inf.valid <= out_inf_array[param.LAT-1].valid
        out_inf_array[param.LAT-1].ready    <= out_inf.ready
    end

end