# require_relative 'ele'
class Axi4 < TdlSpace::TdlBaseInterface
    BOTH = "BOTH"
    ONLY_READ  = "ONLY_READ"
    ONLY_WRITE = "ONLY_WRITE"

    attr_accessor :id,:dsize,:idsize,:asize,:lsize,:mode,:addr_step,:port,:ghost
    hdl_name :axi_inf,:axi4_inf,:axi4
    modports :master,:slaver,:master_wr,:slaver_wr,:master_rd,:slaver_rd,:master_rd_aux,:mirror_rd,:mirror_wr,:master_wr_aux,:master_wr_aux_no_resp
    param_map :dsize,'DSIZE',32 ## <tdl_key><hdl_key><default_value>
    param_map :idsize,"IDSIZE",2
    param_map :asize,"ASIZE",8
    param_map :lsize,"LSIZE",9
    param_map :mode,'MODE','BOTH'
    param_map :addr_step,'ADDR_STEP',2**32-1
    param_map :freqM,'FreqM',1.0
    # param_map :stsize,'STSIZE',4

    clock_io_map :axi_aclk,:axi_aclk,100 ## <tdl_key><hdl_key><default_freqM>
    reset_io_map :axi_aresetn,:axi_aresetn

    sdata_maps :axi_awvalid,:axi_awready,:axi_arvalid,:axi_arready,:axi_bready,:axi_bvalid,:axi_wlast,:axi_wvalid,:axi_wready,:axi_rready,:axi_rlast,:axi_rvalid
    pdata_map :axi_awid,[:idsize]
    pdata_map :axi_arid,[:idsize]
    pdata_map :axi_bid,[:idsize]
    pdata_map :axi_rid,[:idsize]

    pdata_map :axi_awaddr,[:asize]
    pdata_map :axi_araddr,[:asize]

    pdata_map :axi_awlen,[:lsize]
    pdata_map :axi_arlen,[:lsize]

    pdata_map :axi_awsize,[3]
    pdata_map :axi_arsize,[3]

    pdata_map :axi_awburst,[2]
    pdata_map :axi_arburst,[2]

    pdata_map :axi_awlock,[1]
    pdata_map :axi_arlock,[1]

    pdata_map :axi_awcache,[4]
    pdata_map :axi_arcache,[4]

    pdata_map :axi_awprot,[3]
    pdata_map :axi_arprot,[3]

    pdata_map :axi_awqos,[4]
    pdata_map :axi_arqos,[4]

    pdata_map :axi_bresp,[2]

    pdata_map :axi_wdata,[:dsize]
    pdata_map :axi_rdata,[:dsize]

    pdata_map :axi_wstrb,[:stsize]
    pdata_map :axi_rstrb,[:stsize]

    pdata_map :axi_rresp,[2]

    pdata_map :axi_wcnt,[:lsize]
    pdata_map :axi_rcnt,[:lsize]

    # def initialize(name:"axi4",clock:nil,reset:nil,dsize:8,idsize:1,asize:8,lsize:8,mode:BOTH,port:false,addr_step:1.0,dimension:[],freqM:nil,belong_to_module: nil)
    #     super belong_to_module
    #     self.inst_name = name 
    #     self.clock = clock 
    #     self.reset = reset 
    #     self.dsize = dsize 
    #     self.idsize = idsize
    #     self.asize = asize 
    #     self.lsize = lsize
    #     self.mode = mode 
    #     self.modport_type = port
    #     self.addr_step = addr_step
    #     self.dimension = dimension
    #     self.freqM = freqM
    # end
    PORT_REP = /(?<up_down>\(\*\s+(?<ud_name>axi4_up|axi4_down)\s*=\s*"true"\s+\*\))?\s*(axi_inf\.)(?<modport>master|slaver|master_wr|slaver_wr|master_rd|slaver_rd|master_wr_aux|master_wr_aux_no_resp|master_rd_aux|mirror_wr|mirror_rd)\s+(?<name>\w+)\s*(?<vector>\[.*?\])?/m
    UP_STREAM_REP = /axi4_up/

    def inherited(name:inst_name,
        clock: nil ,
        reset: nil,
        mode:  nil,
        dsize: nil,
        idsize: nil,
        asize: nil,
        lsize: nil,
        addr_step: nil,
        dimension: [],
        freqM: nil)

        new_obj = nil 

        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
            append_name = name_copy(name)
            if clock.nil?
                _clock = self.axi_aclk
            else
                _clock = clock
            end

            _freqM = use_which_freq_when_copy(clock,freqM) || (!(_clock.is_a?( Clock)) && self.FreqM)

            if reset.nil?
                _reset = self.axi_aresetn
            else
                _reset = reset
            end
            new_obj = belong_to_module.axi4(
                clock:_clock,
                reset:_reset,
                mode:mode || self.MODE,
                dsize:dsize || self.DSIZE,
                idsize:idsize || self.IDSIZE,
                asize:asize || self.ASIZE,
                lsize:lsize || self.LSIZE,
                addr_step:addr_step || self.ADDR_STEP,
                dimension: dimension ,
                freqM:_freqM) - append_name
        end

        return new_obj
    end

    def branch(name:@name,clock:@clock,reset:@reset,mode:@mode,dsize:@dsize,idsize:@idsize,asize:@asize,lsize:@lsize,addr_step:@addr_step,dimension:[],freqM:nil)
        # puts "freqM :: ",freqM
        a = inherited(name:name,clock:clock,reset:reset,mode:mode,dsize:dsize,idsize:idsize,asize:asize,lsize:lsize,addr_step:addr_step,dimension:dimension,freqM:freqM)
        self << a
        return a
    end

    alias_method :copy,:inherited

    def clock_reset_taps(def_clock_name,def_reset_name)
        super(def_clock_name,def_reset_name,self.axi_aclk,self.axi_aresetn)
    end

end