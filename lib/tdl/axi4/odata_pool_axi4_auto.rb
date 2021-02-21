
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class Axi4


    def _odata_pool_axi4(
        dsize:8,
        rd_clk:"rd_clk",
        rd_rst_n:"rd_rst_n",
        data:"data",
        empty:"empty",
        rd_en:"rd_en",
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        last_drop:"last_drop",
        axi_master:"axi_master"
    )

        Tdl.add_to_all_file_paths('odata_pool_axi4','../../axi/AXI4/odata_pool_axi4.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['odata_pool_axi4','../../axi/AXI4/odata_pool_axi4.sv'])
        return_stream = self
        
        axi_master = Axi4.same_name_socket(:mirror,mix=true,axi_master,nil,belong_to_module) unless axi_master.is_a? String
        
        
        


        belong_to_module.Axi4_draw << _odata_pool_axi4_draw(
            dsize:dsize,
            rd_clk:rd_clk,
            rd_rst_n:rd_rst_n,
            data:data,
            empty:empty,
            rd_en:rd_en,
            source_addr:source_addr,
            size:size,
            valid:valid,
            ready:ready,
            last_drop:last_drop,
            axi_master:axi_master)
        return return_stream
    end

    private

    def _odata_pool_axi4_draw(
        dsize:8,
        rd_clk:"rd_clk",
        rd_rst_n:"rd_rst_n",
        data:"data",
        empty:"empty",
        rd_en:"rd_en",
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        last_drop:"last_drop",
        axi_master:"axi_master"
    )

        large_name_len(
            dsize,
            rd_clk,
            rd_rst_n,
            data,
            empty,
            rd_en,
            source_addr,
            size,
            valid,
            ready,
            last_drop,
            axi_master
        )
        instance_name = "odata_pool_axi4_#{signal}_inst"
"
// FilePath:::../../axi/AXI4/odata_pool_axi4.sv
odata_pool_axi4#(
    .DSIZE    (#{align_signal(dsize)})
) #{instance_name}(
/*  input             */ .rd_clk      (#{align_signal(rd_clk,q_mark=false)}),
/*  input             */ .rd_rst_n    (#{align_signal(rd_rst_n,q_mark=false)}),
/*  output [DSIZE-1:0]*/ .data        (#{align_signal(data,q_mark=false)}),
/*  output            */ .empty       (#{align_signal(empty,q_mark=false)}),
/*  input             */ .rd_en       (#{align_signal(rd_en,q_mark=false)}),
/*  input  [31:0]     */ .source_addr (#{align_signal(source_addr,q_mark=false)}),
/*  input  [31:0]     */ .size        (#{align_signal(size,q_mark=false)}),
/*  input             */ .valid       (#{align_signal(valid,q_mark=false)}),
/*  output            */ .ready       (#{align_signal(ready,q_mark=false)}),
/*  output            */ .last_drop   (#{align_signal(last_drop,q_mark=false)}),
/*  axi_inf.master_rd */ .axi_master  (#{align_signal(axi_master,q_mark=false)})
);
"
    end
    
    public

    def self.odata_pool_axi4(
        dsize:8,
        rd_clk:"rd_clk",
        rd_rst_n:"rd_rst_n",
        data:"data",
        empty:"empty",
        rd_en:"rd_en",
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        last_drop:"last_drop",
        axi_master:"axi_master",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axi_master].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.Axi4_NC._odata_pool_axi4(
            dsize:dsize,
            rd_clk:rd_clk,
            rd_rst_n:rd_rst_n,
            data:data,
            empty:empty,
            rd_en:rd_en,
            source_addr:source_addr,
            size:size,
            valid:valid,
            ready:ready,
            last_drop:last_drop,
            axi_master:axi_master)
        return return_stream
    end
        

end

