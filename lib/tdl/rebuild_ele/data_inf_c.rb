

class DataInf_C < TdlSpace::TdlBaseInterface

    hdl_name :data_inf_c,:data_c
    modports :master,:slaver,:mirror,:mirror_out,:out_mirror
    clock_io_map :clock,:clock,100 ## <tdl_key><hdl_key><default_freqM>
    reset_io_map :rst_n,:rst_n
    param_map    :dsize,'DSIZE',8 ## <tdl_key><hdl_key><default_value>
    param_map :freqM,'FreqM',1.0
    sdata_maps   :valid,:ready
    pdata_map   :data,[:dsize]

    PORT_REP = /(?<up_down>\(\*\s+(?<ud_name>data_up|data_down|up_stream|down_stream)\s*=\s*"true"\s+\*\))?\s*(data_inf_c\.)(?<modport>master|slaver|mirror|out_mirror)\s+(?<name>\w+)\s*(?<vector>\[.*?\])?/m
    UP_STREAM_REP = /data_up/

    # def self.parse_ports(port_array=nil)
    #     rep = /(?<up_down>\(\*\s+(?<ud_name>data_up|data_down|up_stream|down_stream)\s*=\s*"true"\s+\*\))?\s*(data_inf_c\.)(?<modport>master|slaver|mirror|out_mirror)\s+(?<name>\w+)\s*(?<vector>\[.*?\])?/m
    #     up_stream_rep = /data_up/

    #     rh = super(port_array,rep,"data_inf_c",up_stream_rep) do |h|
    #         h[:type]   = DataInf_C
    #         yield h
    #     end
    # end

    def vld_rdy
        # puts method(:valid).source_location
        # puts method(:ready).source_location
        # puts (valid & ready ).class
        # puts valid.method("&").source_location
        valid.to_s.concat(" && ").concat(ready.to_s).to_nq
        # (valid & ready).brackets
        # valid & ready
    end

    def array_chain_vld_rdy_inst(pre_str)
        "(#{pre_str}.valid && #{pre_str}.ready)".to_nq
    end

    def inherited(name: nil,clock: nil,reset: nil,dsize: nil,freqM: nil,dimension:[])
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
            a = belong_to_module.data_inf_c(
                name:append_name,
                clock: clock || self.clock,
                reset: reset || self.rst_n,
                dsize: dsize || self.DSIZE,
                freqM: _freqM || self.freqM,
                dimension: dimension
            ) - append_name
        end
        a
    end

    def clock_reset_taps(def_clock_name,def_reset_name)
        super(def_clock_name,def_reset_name,self.clock,self.rst_n)
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