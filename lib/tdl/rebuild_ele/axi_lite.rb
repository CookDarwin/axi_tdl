# require_relative 'ele'
class AxiLite < TdlSpace::TdlBaseInterface


    attr_accessor :id,:dsize,:asize,:port,:ghost
    
    hdl_name :axi_lite_inf,:axi_lite
    modports :master,:slaver,:master_wr,:slaver_wr,:master_rd,:slaver_rd,:mirror
    param_map :dsize,'DSIZE',32 ## <tdl_key><hdl_key><default_value>
    param_map :asize,'ASIZE',32
    param_map :freqM,'FreqM',1.0

    clock_io_map :axi_aclk,:axi_aclk,100 ## <tdl_key><hdl_key><default_freqM>
    reset_io_map :axi_aresetn,:axi_aresetn

    sdata_maps :axi_awvalid,:axi_awready,:axi_arvalid,:axi_arready,:axi_bready,:axi_bvalid,:axi_wvalid,:axi_wready,:axi_rready,:axi_rvalid

    pdata_map :axi_awaddr,[:asize]
    pdata_map :axi_araddr,[:asize]

    pdata_map :axi_bresp,[2]

    pdata_map :axi_wdata,[:dsize]
    pdata_map :axi_rdata,[:dsize]

    pdata_map :axi_rresp,[2]

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
    PORT_REP = /(?<up_down>\(\*\s+(?<ud_name>axil_up|axil_down)\s*=\s*"true"\s+\*\))?\s*(axi_lite_inf\.)(?<modport>master|slaver|master_rd|slaver_rd|master_wr|slaver_wr)\s+(?<name>\w+)\s*(?<vector>\[.*?\])?/m
    UP_STREAM_REP = /axil_up/

    # def self.parse_ports(port_array=nil)
    #     rep = /(?<up_down>\(\*\s+(?<ud_name>axi4_up|axi4_down)\s*=\s*"true"\s+\*\))?\s*(axi_inf\.)(?<modport>master|slaver|master_wr|slaver_wr|master_rd|slaver_rd|master_wr_aux|master_wr_aux_no_resp|master_rd_aux|mirror_wr|mirror_rd)\s+(?<name>\w+)\s*(?<vector>\[.*?\])?/m
    #     up_stream_rep = /axi4_up/

    #     super(port_array,rep,"axi_inf",up_stream_rep) do |h|
    #         h[:type]   = Axi4
    #         yield h
    #     end
    # end

end