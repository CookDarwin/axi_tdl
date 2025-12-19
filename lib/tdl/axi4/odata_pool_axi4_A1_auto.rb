
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class Axi4


    def _odata_pool_axi4_a1(
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        out_axis:"out_axis",
        axi_master:"axi_master"
    )

        Tdl.add_to_all_file_paths('odata_pool_axi4_a1','../../axi/AXI4/odata_pool_axi4_A1.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['odata_pool_axi4_a1','../../axi/AXI4/odata_pool_axi4_A1.sv'])
        return_stream = self
        
        out_axis = AxiStream.same_name_socket(:to_down,mix=true,out_axis,nil,belong_to_module) unless out_axis.is_a? String
        axi_master = Axi4.same_name_socket(:mirror,mix=true,axi_master,nil,belong_to_module) unless axi_master.is_a? String
        
        
        


        belong_to_module.Axi4_draw << _odata_pool_axi4_a1_draw(
            source_addr:source_addr,
            size:size,
            valid:valid,
            ready:ready,
            out_axis:out_axis,
            axi_master:axi_master)
        return return_stream
    end

    private

    def _odata_pool_axi4_a1_draw(
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        out_axis:"out_axis",
        axi_master:"axi_master"
    )

        large_name_len(
            source_addr,
            size,
            valid,
            ready,
            out_axis,
            axi_master
        )
        instance_name = "odata_pool_axi4_A1_#{signal}_inst"
"
// FilePath:::../../axi/AXI4/odata_pool_axi4_A1.sv
odata_pool_axi4_A1 #{instance_name}(
/*  input  [31:0]        */ .source_addr (#{align_signal(source_addr,q_mark=false)}),
/*  input  [31:0]        */ .size        (#{align_signal(size,q_mark=false)}),
/*  input                */ .valid       (#{align_signal(valid,q_mark=false)}),
/*  output               */ .ready       (#{align_signal(ready,q_mark=false)}),
/*  axi_stream_inf.master*/ .out_axis    (#{align_signal(out_axis,q_mark=false)}),
/*  axi_inf.master_rd    */ .axi_master  (#{align_signal(axi_master,q_mark=false)})
);
"
    end
    
    public

    def self.odata_pool_axi4_a1(
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        out_axis:"out_axis",
        axi_master:"axi_master",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axi_master].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.Axi4_NC._odata_pool_axi4_a1(
            source_addr:source_addr,
            size:size,
            valid:valid,
            ready:ready,
            out_axis:out_axis,
            axi_master:axi_master)
        return return_stream
    end
        

end

