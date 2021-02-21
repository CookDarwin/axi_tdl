
class DataInf < TdlSpace::TdlBaseInterface

    hdl_name :data_inf
    modports :master,:slaver,:mirror,:mirror_out
    param_map :dsize,'DSIZE',8 ## <tdl_key><hdl_key><default_value>
    sdata_maps :valid,:ready
    pdata_map   :data,[:dsize]

    PORT_REP = /(?<up_down>\(\*\s+(?<ud_name>data_up|data_down|up_stream|down_stream)\s*=\s*"true"\s+\*\))?\s*(data_inf\.)(?<modport>master|slaver|mirror)\s+(?<name>\w+)\s*(?<vector>\[.*?\])?/m
    UP_STREAM_REP = /data_up/

    # def self.parse_ports(port_array=nil)
    #     rep = /(?<up_down>\(\*\s+(?<ud_name>data_up|data_down|up_stream|down_stream)\s*=\s*"true"\s+\*\))?\s*(data_inf\.)(?<modport>master|slaver|mirror)\s+(?<name>\w+)\s*(?<vector>\[.*?\])?/m
    #     up_stream_rep = /data_up/

    #     super(port_array,rep,"data_inf",up_stream_rep) do |h|
    #         h[:type]   = DataInf
    #         yield h
    #     end
    # end

    def vld_rdy
        valid.concat(" && ").concat(ready)
    end

end