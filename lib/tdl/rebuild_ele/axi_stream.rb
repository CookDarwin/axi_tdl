# require_relative 'ele'
class AxiStream < TdlSpace::TdlBaseInterface

    hdl_name :axi_stream_inf,:axis
    modports :master,:slaver,:mirror,:mirror_out,:out_mirror
    param_map :dsize,'DSIZE',18 ## <tdl_key><hdl_key><default_value>
    param_map :freqM,'FreqM',1.0
    param_map :usize,'USIZE',1
    clock_io_map :aclk,:aclk,100 ## <tdl_key><hdl_key><default_freqM>
    reset_io_map :aresetn,:aresetn
    _io_map('aclken','aclken',1.b1,'other',nil)
    sdata_maps :axis_tvalid,:axis_tready,:axis_tlast
    pdata_map   :axis_tdata,[:dsize]
    pdata_map   :axis_tkeep,[]
    pdata_map   :axis_tcnt
    pdata_map   :axis_tuser

    # def initialize(name: "test_axis",clock: nil,reset: nil,dsize: nil,port: false,dimension: [],freqM: nil,belong_to_module: nil)
    #     super belong_to_module
    #     self.dsize = dsize
    #     self.clock = clock
    #     self.reset = reset
    #     self.dimension = dimension
    #     self.freqM = freqM
    #     self.inst_name = name
    #     self.modport_type = port
    # end

    PORT_REP = /(?<up_down>\(\*\s+(?<ud_name>axis_up|axis_down|up_stream|down_stream)\s*=\s*"true"\s+\*\))?\s*(axi_stream_inf\.)(?<modport>master|slaver|mirror|out_mirror)\s+(?<name>\w+)\s*(?<vector>\[.*?\])?/m
    UP_STREAM_REP = Regexp.union(/axis_up/,/up_stream/)

    # def self.parse_ports(port_array=nil)
    #     rep = /(?<up_down>\(\*\s+(?<ud_name>axis_up|axis_down|up_stream|down_stream)\s*=\s*"true"\s+\*\))?\s*(axi_stream_inf\.)(?<modport>master|slaver|mirror|out_mirror)\s+(?<name>\w+)\s*(?<vector>\[.*?\])?/m
    #     up_stream_rep = Regexp.union(/axis_up/,/up_stream/)

    #     super(port_array,rep,"axi_stream_inf",up_stream_rep) do |h|
    #         h[:type]   = AxiStream
    #         yield h
    #     end
    # end

    def vld_rdy
        axis_tvalid.to_s.concat(" && ").concat(axis_tready.to_s).to_nq
    end

    def array_chain_vld_rdy_inst(pre_str)
        "(#{pre_str}.axis_tvalid && #{pre_str}.axis_tready )".to_nq
    end

    def vld_rdy_last
        axis_tvalid.to_s.concat(" && ").concat(axis_tready.to_s).concat(" && ").concat(axis_tlast.to_s).to_nq
    end

    def array_chain_vld_rdy_last_inst(pre_str)
        "(#{pre_str}.axis_tvalid && #{pre_str}.axis_tready && #{pre_str}.axis_tlast)".to_nq
    end

    def clock_reset_taps(def_clock_name,def_reset_name)
        super(def_clock_name,def_reset_name,self.aclk,self.aresetn)
    end

    def inherited(name: nil ,clock: nil,reset: nil,dsize: nil,freqM: nil,dimension:[])
        a = nil 
        unless name 
            name = "#{inst_name}_inherited#{globle_random_name_flag()}"
        end
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
            append_name = name_copy(name)
            _freqM = use_which_freq_when_copy(clock,freqM)
            # a = belong_to_module.Def.datainf_c(
            #     name:append_name,
            #     clock: clock || self.clock,
            #     reset: reset || self.rst_n,
            #     dsize: dsize || self.DSIZE,
            #     freqM: _freqM,
            #     dimension: dimension)
            a = belong_to_module.axi_stream_inf(
                name:append_name,
                clock: clock || self.aclk,
                reset: reset || self.aresetn,
                dsize: dsize || self.DSIZE,
                freqM: _freqM || self.freqM,
                dimension: dimension
            ) - append_name
        end
        a
    end

    ## =======================
    def self.leave_empty(curr_type: :master,dsize:8,clock:"",reset:"",belong_to_module:nil)
        nc = belong_to_module.axi_stream_inf(dsize:dsize,clock:clock,reset:reset) - "empty_axis_#{globle_random_name_flag()}"
        # puts belong_to_module.module_name
        if curr_type.to_sym == :slaver
            # self.axis_master_empty(master:nc)
            belong_to_module.Instance(:axis_master_empty,"axis_master_empty_#{nc.name}") do |h|
                h.master    nc 
            end
        elsif curr_type.to_sym == :master
            # self.axis_slaver_empty(slaver:nc)
            belong_to_module.Instance(:axis_slaver_empty,"axis_slaver_empty_#{nc.name}") do |h|
                h.slaver    nc 
            end
        else
            raise TdlError.new("\n\n Axi Stream don't has this type << #{type} >> \n\n")
        end

        return nc
    end

    def branch(name: nil,clock:@clock,reset:@reset,dsize:@dsize,freqM:nil)
        unless name 
            name = "#{inst_name}_branch#{globle_random_name_flag()}"
        end
        a =  inherited(name: name,clock: clock,reset: reset,dsize: dsize,freqM: freqM)
        self << a
        return a
    end

    alias_method :copy,:inherited

end