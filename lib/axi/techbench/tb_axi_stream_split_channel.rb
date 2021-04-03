<<<<<<< HEAD
require 'axi_tdl'
=======
require_relative '../../axi_tdl.rb'
>>>>>>> 91ef261... belong_to_module ex
require_sdl 'axi_stream_split_channel.rb'

TdlBuild.tb_axi_stream_split_channel(__dir__) do 

    logic.clock(100)    - 'clock'
    logic.reset('low')  - 'rst_n'

    clock.to_sim_source
    rst_n.to_sim_source(200)    # keep 200ns when initial

    axi_stream_inf(clock: clock, reset: rst_n, dsize:8) - 'origin_inf'
    origin_inf.copy(name: 'first_inf')
    origin_inf.copy(name: 'end_inf')

    axi_stream_split_channel.axis_split_channel_inst do |h|
        h.input[16].split_len               logic[16].split_len       # 1:need 1 size ; split len must large than 2
        h.port.axis.slaver.origin_inf       origin_inf           
        h.port.axis.master.first_inf        first_inf            
        h.port.axis.master.end_inf          end_inf          
    end

    origin_param = {
        split_len:  [3,4,5,6],
        length:     [16,32,24,50,12],
        gap_len:    [3,0,1,0,5],
        data:       [(0..100)],
        vld_perc:   [50,100,30,80]
    }

    split_len.to_sim_source_coe(
        data: origin_param[:split_len] * ( (origin_param[:length].size/ origin_param[:split_len].size + 1)), 
        posedge: nil ,
        negedge: origin_inf.vld_rdy_last
    )

    origin_inf.to_simple_sim_master_coe(
        length:     origin_param[:length], 
        gap_len:    origin_param[:gap_len], 
        data:       origin_param[:data], 
        vld_perc:   origin_param[:vld_perc]
    )

    first_inf.to_simple_sim_slaver([50,100,30])
    end_inf.to_simple_sim_slaver([100,50,100])


    ## 验证输出
    fcollect = []
    ecollect = []
    origin_param[:length].each_index do |index|
        _data = origin_param[:data][index] || origin_param[:data][0]
        _data = _data.to_a[0,origin_param[:length][index]]

        insert_seed = origin_param[:split_len][index] || origin_param[:split_len][0]

        # _data.insert(insert_seed,_data[insert_seed])

        fcollect += _data[0,insert_seed]
        fcollect[fcollect.size-1] = fcollect.last + 256 
        ecollect += _data[insert_seed, _data.size-insert_seed]
        ecollect[ecollect.size-1] = ecollect.last + 256 
    end


    first_inf.simple_verify_by_coe(AxiTdl::Verification::CoeArray.new(fcollect).coe)
    end_inf.simple_verify_by_coe(AxiTdl::Verification::CoeArray.new(ecollect).coe)

end