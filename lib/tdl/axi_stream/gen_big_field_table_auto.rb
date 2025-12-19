
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def gen_big_field_table(
        master_mode:"OFF",
        dsize:8,
        field_len:16*8,
        field_name:"Big Filed",
        enable:"enable",
        value:"value",
        cm_tb:"cm_tb",
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('gen_big_field_table','../../axi/AXI_stream/gen_big_field_table.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['gen_big_field_table','../../axi/AXI_stream/gen_big_field_table.sv'])
        return_stream = self
        
        cm_tb = AxiStream.same_name_socket(:to_down,mix=true,cm_tb,nil,belong_to_module) unless cm_tb.is_a? String
        
        
        unless self.eql? belong_to_module.AxiStream_NC
            cm_tb = self
        else
            if down_stream
                cm_tb = down_stream
            end
        end


        belong_to_module.AxiStream_draw << gen_big_field_table_draw(
            master_mode:master_mode,
            dsize:dsize,
            field_len:field_len,
            field_name:field_name,
            enable:enable,
            value:value,
            cm_tb:cm_tb,
            down_stream:down_stream)
        return return_stream
    end

    private

    def gen_big_field_table_draw(
        master_mode:"OFF",
        dsize:8,
        field_len:16*8,
        field_name:"Big Filed",
        enable:"enable",
        value:"value",
        cm_tb:"cm_tb",
        down_stream:nil
    )

        large_name_len(
            master_mode,
            dsize,
            field_len,
            field_name,
            enable,
            value,
            cm_tb
        )
        instance_name = "gen_big_field_table_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/gen_big_field_table.sv
gen_big_field_table#(
    .MASTER_MODE    (#{align_signal(master_mode)}),
    .DSIZE          (#{align_signal(dsize)}),
    .FIELD_LEN      (#{align_signal(field_len)}),
    .FIELD_NAME     (#{align_signal(field_name)})
) #{instance_name}(
/*  input                       */ .enable (#{align_signal(enable,q_mark=false)}),
/*  input  [DSIZE*FIELD_LEN-1:0]*/ .value  (#{align_signal(value,q_mark=false)}),
/*  axi_stream_inf.master       */ .cm_tb  (#{align_signal(cm_tb,q_mark=false)})
);
"
    end
    
    public

    def self.gen_big_field_table(
        master_mode:"OFF",
        dsize:8,
        field_len:16*8,
        field_name:"Big Filed",
        enable:"enable",
        value:"value",
        cm_tb:"cm_tb",
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [cm_tb].first.belong_to_module unless belong_to_module
        
        
        
        if down_stream.is_a? AxiStream
            down_stream.gen_big_field_table(
                master_mode:master_mode,
                dsize:dsize,
                field_len:field_len,
                field_name:field_name,
                enable:enable,
                value:value,
                cm_tb:cm_tb,
                down_stream:down_stream)
        elsif cm_tb.is_a? AxiStream
            cm_tb.gen_big_field_table(
                master_mode:master_mode,
                dsize:dsize,
                field_len:field_len,
                field_name:field_name,
                enable:enable,
                value:value,
                cm_tb:cm_tb,
                down_stream:down_stream)
        else
            belong_to_module.AxiStream_NC.gen_big_field_table(
                master_mode:master_mode,
                dsize:dsize,
                field_len:field_len,
                field_name:field_name,
                enable:enable,
                value:value,
                cm_tb:cm_tb,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

