
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def parse_big_field_table(
        dsize:8,
        field_len:16*8,
        field_name:"Big Filed",
        try_parse:"OFF",
        enable:"enable",
        value:"value",
        out_valid:"out_valid",
        cm_tb_s:"cm_tb_s",
        cm_tb_m:"cm_tb_m",
        cm_mirror:"cm_mirror",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('parse_big_field_table','../../axi/AXI_stream/parse_big_field_table.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['parse_big_field_table','../../axi/AXI_stream/parse_big_field_table.sv'])
        return_stream = self
        
        cm_tb_s = AxiStream.same_name_socket(:from_up,mix=true,cm_tb_s,nil,belong_to_module) unless cm_tb_s.is_a? String
        cm_tb_m = AxiStream.same_name_socket(:to_down,mix=true,cm_tb_m,nil,belong_to_module) unless cm_tb_m.is_a? String
        cm_mirror = AxiStream.same_name_socket(:mirror,mix=true,cm_mirror,nil,belong_to_module) unless cm_mirror.is_a? String
        
        if up_stream.nil? && cm_tb_s.eql?("cm_tb_s") && (!(cm_tb_m.eql?("cm_tb_m")) || !down_stream.nil?)
            # up_stream = self.copy(name:"cm_tb_s")
            # return_stream = up_stream
            cm_tb_m = down_stream if down_stream
            return down_stream.parse_big_field_table(cm_tb_s:self)
        end

        cm_tb_s = up_stream if up_stream
        unless self.eql? belong_to_module.AxiStream_NC
            cm_tb_m = self
        else
            if down_stream
                cm_tb_m = down_stream
            end
        end


        belong_to_module.AxiStream_draw << parse_big_field_table_draw(
            dsize:dsize,
            field_len:field_len,
            field_name:field_name,
            try_parse:try_parse,
            enable:enable,
            value:value,
            out_valid:out_valid,
            cm_tb_s:cm_tb_s,
            cm_tb_m:cm_tb_m,
            cm_mirror:cm_mirror,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def parse_big_field_table_draw(
        dsize:8,
        field_len:16*8,
        field_name:"Big Filed",
        try_parse:"OFF",
        enable:"enable",
        value:"value",
        out_valid:"out_valid",
        cm_tb_s:"cm_tb_s",
        cm_tb_m:"cm_tb_m",
        cm_mirror:"cm_mirror",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            dsize,
            field_len,
            field_name,
            try_parse,
            enable,
            value,
            out_valid,
            cm_tb_s,
            cm_tb_m,
            cm_mirror
        )
        instance_name = "parse_big_field_table_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/parse_big_field_table.sv
parse_big_field_table#(
    .DSIZE         (#{align_signal(dsize)}),
    .FIELD_LEN     (#{align_signal(field_len)}),
    .FIELD_NAME    (#{align_signal(field_name)}),
    .TRY_PARSE     (#{align_signal(try_parse)})
) #{instance_name}(
/*  input                       */ .enable    (#{align_signal(enable,q_mark=false)}),
/*  output [DSIZE*FIELD_LEN-1:0]*/ .value     (#{align_signal(value,q_mark=false)}),
/*  output                      */ .out_valid (#{align_signal(out_valid,q_mark=false)}),
/*  axi_stream_inf.slaver       */ .cm_tb_s   (#{align_signal(cm_tb_s,q_mark=false)}),
/*  axi_stream_inf.master       */ .cm_tb_m   (#{align_signal(cm_tb_m,q_mark=false)}),
/*  axi_stream_inf.mirror       */ .cm_mirror (#{align_signal(cm_mirror,q_mark=false)})
);
"
    end
    
    public

    def self.parse_big_field_table(
        dsize:8,
        field_len:16*8,
        field_name:"Big Filed",
        try_parse:"OFF",
        enable:"enable",
        value:"value",
        out_valid:"out_valid",
        cm_tb_s:"cm_tb_s",
        cm_tb_m:"cm_tb_m",
        cm_mirror:"cm_mirror",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [cm_tb_s,cm_tb_m,cm_mirror].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && cm_tb_m.eql?("cm_tb_m")
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy
            else
                down_stream = cm_tb_s.copy
            end
            return_stream = down_stream
        end

        
        if up_stream.nil? && cm_tb_s.eql?("cm_tb_s")
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy
            else
                up_stream = cm_tb_m.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.parse_big_field_table(
                dsize:dsize,
                field_len:field_len,
                field_name:field_name,
                try_parse:try_parse,
                enable:enable,
                value:value,
                out_valid:out_valid,
                cm_tb_s:cm_tb_s,
                cm_tb_m:cm_tb_m,
                cm_mirror:cm_mirror,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif cm_tb_m.is_a? AxiStream
            cm_tb_m.parse_big_field_table(
                dsize:dsize,
                field_len:field_len,
                field_name:field_name,
                try_parse:try_parse,
                enable:enable,
                value:value,
                out_valid:out_valid,
                cm_tb_s:cm_tb_s,
                cm_tb_m:cm_tb_m,
                cm_mirror:cm_mirror,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.AxiStream_NC.parse_big_field_table(
                dsize:dsize,
                field_len:field_len,
                field_name:field_name,
                try_parse:try_parse,
                enable:enable,
                value:value,
                out_valid:out_valid,
                cm_tb_s:cm_tb_s,
                cm_tb_m:cm_tb_m,
                cm_mirror:cm_mirror,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

