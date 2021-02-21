
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class Axi4


    def idata_pool_axi4(
        dsize:8,
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        last_drop:"last_drop",
        data:"data",
        empty:"empty",
        wr_en:"wr_en",
        sewage_valve:"sewage_valve",
        axi_master:"axi_master",
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('idata_pool_axi4','../../axi/AXI4/idata_pool_axi4.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['idata_pool_axi4','../../axi/AXI4/idata_pool_axi4.sv'])
        return_stream = self
        
        axi_master = Axi4.same_name_socket(:mirror,mix=true,axi_master,nil,belong_to_module) unless axi_master.is_a? String
        
        
        unless self.eql? belong_to_module.Axi4_NC
            axi_master = self
        else
            if down_stream
                axi_master = down_stream
            end
        end


        belong_to_module.Axi4_draw << idata_pool_axi4_draw(
            dsize:dsize,
            source_addr:source_addr,
            size:size,
            valid:valid,
            ready:ready,
            last_drop:last_drop,
            data:data,
            empty:empty,
            wr_en:wr_en,
            sewage_valve:sewage_valve,
            axi_master:axi_master,
            down_stream:down_stream)
        return return_stream
    end

    private

    def idata_pool_axi4_draw(
        dsize:8,
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        last_drop:"last_drop",
        data:"data",
        empty:"empty",
        wr_en:"wr_en",
        sewage_valve:"sewage_valve",
        axi_master:"axi_master",
        down_stream:nil
    )

        large_name_len(
            dsize,
            source_addr,
            size,
            valid,
            ready,
            last_drop,
            data,
            empty,
            wr_en,
            sewage_valve,
            axi_master
        )
        instance_name = "idata_pool_axi4_#{signal}_inst"
"
// FilePath:::../../axi/AXI4/idata_pool_axi4.sv
idata_pool_axi4#(
    .DSIZE    (#{align_signal(dsize)})
) #{instance_name}(
/*  input  [31:0]     */ .source_addr  (#{align_signal(source_addr,q_mark=false)}),
/*  input  [31:0]     */ .size         (#{align_signal(size,q_mark=false)}),
/*  input             */ .valid        (#{align_signal(valid,q_mark=false)}),
/*  output            */ .ready        (#{align_signal(ready,q_mark=false)}),
/*  output            */ .last_drop    (#{align_signal(last_drop,q_mark=false)}),
/*  input  [DSIZE-1:0]*/ .data         (#{align_signal(data,q_mark=false)}),
/*  output            */ .empty        (#{align_signal(empty,q_mark=false)}),
/*  input             */ .wr_en        (#{align_signal(wr_en,q_mark=false)}),
/*  input             */ .sewage_valve (#{align_signal(sewage_valve,q_mark=false)}),
/*  axi_inf.master_wr */ .axi_master   (#{align_signal(axi_master,q_mark=false)})
);
"
    end
    
    public

    def self.idata_pool_axi4(
        dsize:8,
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        last_drop:"last_drop",
        data:"data",
        empty:"empty",
        wr_en:"wr_en",
        sewage_valve:"sewage_valve",
        axi_master:"axi_master",
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axi_master].first.belong_to_module unless belong_to_module
        
        
        
        if down_stream.is_a? Axi4
            down_stream.idata_pool_axi4(
                dsize:dsize,
                source_addr:source_addr,
                size:size,
                valid:valid,
                ready:ready,
                last_drop:last_drop,
                data:data,
                empty:empty,
                wr_en:wr_en,
                sewage_valve:sewage_valve,
                axi_master:axi_master,
                down_stream:down_stream)
        elsif axi_master.is_a? Axi4
            axi_master.idata_pool_axi4(
                dsize:dsize,
                source_addr:source_addr,
                size:size,
                valid:valid,
                ready:ready,
                last_drop:last_drop,
                data:data,
                empty:empty,
                wr_en:wr_en,
                sewage_valve:sewage_valve,
                axi_master:axi_master,
                down_stream:down_stream)
        else
            belong_to_module.Axi4_NC.idata_pool_axi4(
                dsize:dsize,
                source_addr:source_addr,
                size:size,
                valid:valid,
                ready:ready,
                last_drop:last_drop,
                data:data,
                empty:empty,
                wr_en:wr_en,
                sewage_valve:sewage_valve,
                axi_master:axi_master,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

