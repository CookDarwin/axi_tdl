require_hdl 'common_fifo.sv'

TdlBuild.data_inf_partition_A1(__dir__) do
    parameter.PLEN          128 

    parameter.IASIZE        32
    parameter.ILSIZE         8
    parameter.IIDSIZE        4

    parameter.OASIZE         32
    parameter.OLSIZE         8
    parameter.OIDSIZE        4

    parameter.ADDR_STEP     1
    port.data_inf_c.slaver  - 'data_in'     #[in ID..][ADDR...][LENGTH| LSIZE-1:0] length `0 mean 1
    port.data_inf_c.master  - 'data_out'    #[out ID][in ID..][LENGTH| LSIZE-1:0]

    port.data_inf_c.master  - 'partition_pulse_inf'
    port.data_inf_c.master  - 'wait_last_inf'

    Initial do 
        assert(data_in.DSIZE == (param.IASIZE+param.ILSIZE+param.IIDSIZE),"data_in.DSIZE<%0d> != param.IASIZE<%0d>+param.ILSIZE<%0d>+param.IIDSIZE<%0d>",data_in.DSIZE,param.IASIZE,param.ILSIZE,param.IIDSIZE)
        assert(data_out.DSIZE == (param.OASIZE+param.OLSIZE+param.OIDSIZE),"data_out.DSIZE<%0d> != param.OASIZE<%0d>+param.OLSIZE<%0d>+param.OIDSIZE<%0d>",data_out.DSIZE,param.OASIZE,param.OLSIZE,param.OIDSIZE)
    end

    enum('IDLE','LOCK','Px','Pl','HOLD','WAT_PP','DONE','WAIT')    - 'ps'

    data_in.clock_reset_taps('clock','rst_n')

    always_ff(posedge.clock, negedge.rst_n) do 
        IF ~rst_n do 
            ps.C    <= ps.IDLE 
        end 
        ELSE do 
            ps.C    <= ps.N 
        end
    end

    logic   - 'tail_len'
    logic   - 'one_long_stream'
    logic   - 'fifo_wr'
    logic   - 'fifo_full'
    logic   - 'fifo_empty'

    always_comb do 
        CASE ps.C do 
            WHEN ps.IDLE do 
                IF data_in.vld_rdy do 
                    ps.N    <= ps.LOCK 
                end
                ELSE do 
                    ps.N    <= ps.IDLE 
                end
            end
            WHEN ps.LOCK do 
                # ps.N    <= ps.HOLD
                IF one_long_stream do 
                    ps.N    <= ps.Pl   
                end
                ELSE do 
                    ps.N    <= ps.WAT_PP
                end
            end
            WHEN ps.WAT_PP do 
                IF partition_pulse_inf.vld_rdy do 
                    ps.N    <= ps.Px 
                end 
                ELSE do 
                    ps.N    <= ps.WAT_PP
                end
            end
            WHEN ps.Px do 
                IF ~fifo_full do 
                    ps.N    <= ps.HOLD 
                end
                ELSE do 
                    ps.N    <= ps.Px 
                end
            end
            WHEN ps.HOLD do 
                IF tail_len do 
                    ps.N    <= ps.Pl 
                end
                ELSE do 
                    ps.N    <= ps.WAT_PP 
                end
            end
            WHEN ps.Pl do 
                IF ~fifo_full do 
                    ps.N    <= ps.DONE 
                end
                ELSE do 
                    ps.N    <= ps.Pl 
                end
            end
            WHEN ps.DONE do 
                IF fifo_empty do 
                    ps.N    <= ps.WAIT
                end
                ELSE do 
                    ps.N    <= ps.DONE
                end
            end
            WHEN ps.WAIT do 
                IF wait_last_inf.vld_rdy do 
                    ps.N    <= ps.IDLE 
                end
                ELSE do 
                    ps.N    <= ps.WAIT 
                end
            end
            DEFAULT do 
                ps.N    <= ps.IDLE 
            end
        end
    end

    always_ff(posedge.clock,negedge.rst_n) do 
        IF ~rst_n do
            data_in.ready   <= 1.b0 
        end
        ELSE do 
            CASE ps.N do 
                WHEN ps.IDLE do 
                    data_in.ready   <= 1.b1 
                end
                DEFAULT do 
                    data_in.ready   <= 1.b0 
                end
            end
        end 
    end

    logic[param.OIDSIZE]                 - 'curr_id'
    # logic[param.OLSIZE]                  - 'curr_length'
    logic[param.OASIZE]                  - 'curr_addr'
    logic[param.ILSIZE]                   - 'curr_length'
    # logic[param.IASIZE]                  - 'curr_addr'

    logic[param.OLSIZE]                  - 'wr_length'

    always_ff(posedge.clock,negedge.rst_n) do 
        IF ~rst_n do
            curr_addr   <= 0.A 
            curr_length <= 0.A 
        end
        ELSE do 
            CASE ps.N do 
                WHEN ps.LOCK do 
                    one_long_stream <= data_in.data[param.ILSIZE-1,0] < param.PLEN
                    curr_id  <= 0.A 
                    curr_length     <= data_in.data[param.ILSIZE-1,0]
                    curr_addr       <= data_in.data[param.ILSIZE+param.IASIZE-1, param.ILSIZE]
                    # curr_id         <= data_in.data[param.ILSIZE+param.IASIZE+param.IIDSIZE-1, param.ILSIZE+param.IASIZE]
                end
                WHEN ps.HOLD do 
                    curr_length <= curr_length - param.PLEN
                    curr_addr   <= curr_addr + param.ADDR_STEP*param.PLEN/1024
                    curr_id     <= curr_id + 1.b1
                end
                WHEN ps.IDLE, ps.DONE do 
                    one_long_stream <= 1.b0 
                end
            end
        end
    end 

    always_ff(posedge.clock,negedge.rst_n) do 
        IF ~rst_n do 
            tail_len    <= 1.b0 
        end
        ELSE do 
            CASE ps.N do 
                WHEN ps.LOCK do 
                    tail_len    <= (data_in.data[param.ILSIZE-1,0] < param.PLEN)
                end
                WHEN ps.HOLD do 
                    IF curr_length < (param.PLEN*2-0) do 
                        tail_len    <= 1.b1 
                    end
                    ELSE do 
                        tail_len    <= 1.b0 
                    end
                end
            end
        end
    end

    always_ff(posedge.clock,negedge.rst_n) do 
        IF ~rst_n do 
            wr_length   <= 0.A 
            fifo_wr     <= 1.b0 
        end
        ELSE do 
            CASE ps.N do 
                WHEN ps.Px do 
                    wr_length   <= param.PLEN - 1.b1 
                    fifo_wr     <= 1.b1 
                end
                WHEN ps.Pl do 
                    wr_length   <= curr_length
                    fifo_wr     <= 1.b1 
                end 
                DEFAULT do 
                    fifo_wr     <= 1.b0 
                end
            end
        end 
    end

    always_ff(posedge.clock,negedge.rst_n) do 
        IF ~rst_n do
            partition_pulse_inf.valid   <= 1.b0
            partition_pulse_inf.data    <= 0.A
        end 
        ELSE do 
            CASE ps.N do 
                WHEN ps.WAT_PP do 
                    partition_pulse_inf.valid   <= 1.b1
                    partition_pulse_inf.data    <= 0.A
                end
                DEFAULT do 
                    partition_pulse_inf.valid   <= 1.b0
                    partition_pulse_inf.data    <= 0.A
                end
            end
        end
    end

    common_fifo.common_fifo_inst do |h|
        h.param.DEPTH       6
        # h.param.DSIZE                   data_out.DSIZE
        h.param.DSIZE                   param.OIDSIZE+param.OASIZE+param.OLSIZE
        h.input.clock                   data_in.clock
        h.input.rst_n                   data_in.rst_n
        h.input['DSIZE'].wdata          logic_bind_(curr_id,curr_addr,wr_length)
        h.input.wr_en                   fifo_wr & ~fifo_full
        h.output['DSIZE'].rdata         data_out.data
        h.input.rd_en                   data_out.vld_rdy
        h.output.logic.empty            fifo_empty
        h.output.logic.full             fifo_full
    end

    Assign do 
        data_out.valid  <= ~fifo_empty
    end

    ## ----- wait last ack ---------
    always_ff(posedge.clock,negedge.rst_n) do 
        IF ~rst_n do
            wait_last_inf.data  <= 0.A 
            wait_last_inf.valid <= 0.A 
        end
        ELSE do 
            CASE ps.N do 
                WHEN ps.WAIT do 
                    wait_last_inf.data  <= 0.A 
                    wait_last_inf.valid <= 1.b1
                end
                DEFAULT do 
                    wait_last_inf.data  <= 0.A 
                    wait_last_inf.valid <= 1.b0
                end
            end
        end
    end

    ### Track 
    # debugLogic[10]  - 'st5_cnt'
    # debugLogic      - 'track_st5'

    logic[10]  - 'st5_cnt'
    logic      - 'track_st5'

    always_ff(posedge.clock,negedge.rst_n) do 
        IF ~rst_n do
            st5_cnt     <= 0.A 
            track_st5   <= 1.b0 
        end
        ELSE do 
            CASE ps.N do 
                WHEN ps.WAT_PP do 
                    st5_cnt     <= st5_cnt + 1.b1 
                    track_st5   <= st5_cnt > 10.d200 
                end
                WHEN ps.WAIT do 
                    st5_cnt     <= st5_cnt + 1.b1 
                    track_st5   <= st5_cnt > 10.d1000 
                end
                DEFAULT do 
                    st5_cnt     <= 0.A 
                    track_st5   <= 1.b0 
                end
            end
        end
    end

end