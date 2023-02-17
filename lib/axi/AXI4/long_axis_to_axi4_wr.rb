# require_relative "../prj_lib"
require_hdl "axis_length_split_with_addr.sv"
require_hdl 'axi_stream_long_fifo_verb.sv'
require_shdl 'axi4_wr_auxiliary_gen_without_resp','axis_valve_with_pipe'
require_shdl 'independent_clock_fifo'

TdlBuild.long_axis_to_axi4_wr(__dir__) do
    parameter.BYTE_DEPTH    8192*2

    input[32]               - :addr
    input[32]               - :max_length
    port.axis.slaver        - 'axis_in'
    port.axi4.master_wr     - 'axi_wr'

    Initial do 
        assert(axis_in.DSIZE == axi_wr.DSIZE, "STREAM DSIZE<%d> should eql AXI4 DSIZE<%d>",axis_in.DSIZE, axi_wr.DSIZE)
    end

    Def().logic(name: "addr_cur",dsize:32)

    axis_length_split_with_addr.axis_length_split_with_addr_inst do |h|
        h.param.ADDR_STEP       axi_wr.ADDR_STEP       
        h.origin_addr           addr
        h.length                max_length
        h.band_addr             addr_cur
        h.axis_in               axis_in
        h.axis_out              axis_in.copy(name: 'split_out')
    end

    axi_stream_long_fifo_verb.axi_stream_long_fifo_verb_inst do |h|
        h.param.DEPTH           4
        h.param.BYTE_DEPTH      param.BYTE_DEPTH
        h.port.axis.slaver.axis_in      split_out
        h.port.axis.master.axis_out     split_out.copy(name:'fifo_axis',clock:axi_wr.axi_aclk,reset:axi_wr.axi_aresetn,dsize:axis_in.DSIZE)
    end

    Def().logic(name: :id,dsize:axi_wr.idsize)
    Def().logic(name: :addr_s,dsize:axi_wr.asize)
    Def().logic(name: :len_s,dsize:axi_wr.lsize)

    Instance(:independent_clock_fifo,"independent_clock_fifo_inst") do |h|
        h[:DEPTH]       = 4
        h[:DSIZE]       = NqString.new("#{axi_wr.idsize} + #{axi_wr.asize} + #{axi_wr.lsize}")
        h[:wr_clk]      = axis_in.aclk
        h[:wr_rst_n]    = axis_in.aresetn
        h[:rd_clk]      = axi_wr.axi_aclk
        h[:rd_rst_n]    = axi_wr.axi_aresetn
        h[:wdata]       = "{#{id.s},#{addr_s.s},#{len_s.s}}".to_nq
        h[:wr_en]       = split_out.vld_rdy_last
        h[:rdata]       = Def().logic(name:"fifo_rdata",dsize:h[:DSIZE])
        h[:rd_en]       = Def().logic(name:"fifo_rd_en")
        h[:empty]       = Def().logic(name:"fifo_empty")
        h[:full]        = Def().logic(name:"fifo_full")
    end

    # AxiStream.axi4_wr_auxiliary_gen_without_resp(
    #     stream_en:          Def().logic(name:"stream_en"),
    #     id_add_len_in:      Def().axi_stream(name:"id_add_len_in",clock:axi_wr.axi_aclk,reset:axi_wr.axi_aresetn,dsize:"#{axi_wr.idsize} + #{axi_wr.asize} + #{axi_wr.lsize}"),
    #     axi_wr_aux:         axi_wr,
    #     belong_to_module:   self
    # )

    Instance(:axi4_wr_auxiliary_gen_without_resp,"axi4_wr_auxiliary_gen_without_resp_inst") do |h|
        h[:stream_en]       = Def().logic(name: "stream_en")
        # h[:id_add_len_in]   = Def().axi_stream(name:"id_add_len_in",clock:axi_wr.axi_aclk,reset:axi_wr.axi_aresetn,dsize:"#{axi_wr.idsize} + #{axi_wr.asize} + #{axi_wr.lsize}")
        h[:id_add_len_in]   = axi_stream_inf(clock:axi_wr.axi_aclk,reset:axi_wr.axi_aresetn,dsize:"#{axi_wr.idsize} + #{axi_wr.asize} + #{axi_wr.lsize}".to_nq).id_add_len_in
        h[:axi_wr_aux]      = axi_wr
    end

    Always(posedge:axis_in.aclk,negedge:axis_in.aresetn) do
        IF ~axis_in.aresetn do
            id <= 0
         end
        ELSIF split_out.vld_rdy_last do
            id <= id + 1
        end
        ELSE do
            id <= id
        end
    end

    Assign do
        addr_s  <= addr_cur
        len_s   <= split_out.axis_tcnt
        id_add_len_in.axis_tvalid           <= ~independent_clock_fifo_inst[:empty]
        id_add_len_in.axis_tdata            <= independent_clock_fifo_inst[:rdata]
        id_add_len_in.axis_tlast            <= 1.b1
        independent_clock_fifo_inst[:rd_en] <= id_add_len_in.axis_tready
    end

    # pipe_axis = AxiStream.axis_valve_with_pipe(
    #     mode:       "OUT",
    #     button:     stream_en,
    #     up_stream:  fifo_axis,
    #     belong_to_module:self)

    axis_valve_with_pipe.axis_valve_with_pipe_inst do |h|
        h.parameter.MODE            "OUT"
        h.input.button              stream_en         # //[1] OPEN ; [0] CLOSE
        h.axis_in                   fifo_axis
        h.axis_out                  fifo_axis.copy(name: 'pipe_axis')
    end

    Assign do
        axi_wr.axi_wdata      <= pipe_axis.axis_tdata
        axi_wr.axi_wstrb      <= ~pipe_axis.axis_tkeep
        axi_wr.axi_wvalid     <= pipe_axis.axis_tvalid
        axi_wr.axi_wlast      <= pipe_axis.axis_tlast
        pipe_axis.axis_tready <= axi_wr.axi_wready
        axi_wr.axi_bready     <= 1.b1
    end

    
end
