
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class DataInf_C


    def data_uncompress(
        asize:8,
        lsize:8,
        data_zip:"data_zip",
        data_unzip:"data_unzip",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('data_uncompress','../../axi/data_interface/data_inf_c/data_uncompress.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['data_uncompress','../../axi/data_interface/data_inf_c/data_uncompress.sv'])
        return_stream = self
        
        data_zip = DataInf_C.same_name_socket(:from_up,mix=true,data_zip,nil,belong_to_module) unless data_zip.is_a? String
        data_unzip = DataInf_C.same_name_socket(:to_down,mix=true,data_unzip,nil,belong_to_module) unless data_unzip.is_a? String
        
        if up_stream.nil? && data_zip.eql?("data_zip") && (!(data_unzip.eql?("data_unzip")) || !down_stream.nil?)
            # up_stream = self.copy(name:"data_zip")
            # return_stream = up_stream
            data_unzip = down_stream if down_stream
            return down_stream.data_uncompress(data_zip:self)
        end

        data_zip = up_stream if up_stream
        unless self.eql? belong_to_module.DataInf_C_NC
            data_unzip = self
        else
            if down_stream
                data_unzip = down_stream
            end
        end


        belong_to_module.DataInf_C_draw << data_uncompress_draw(
            asize:asize,
            lsize:lsize,
            data_zip:data_zip,
            data_unzip:data_unzip,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def data_uncompress_draw(
        asize:8,
        lsize:8,
        data_zip:"data_zip",
        data_unzip:"data_unzip",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            asize,
            lsize,
            data_zip,
            data_unzip
        )
        instance_name = "data_uncompress_#{signal}_inst"
"
// FilePath:::../../axi/data_interface/data_inf_c/data_uncompress.sv
data_uncompress#(
    .ASIZE    (#{align_signal(asize)}),
    .LSIZE    (#{align_signal(lsize)})
) #{instance_name}(
/*  data_inf_c.slaver*/ .data_zip   (#{align_signal(data_zip,q_mark=false)}),
/*  data_inf_c.master*/ .data_unzip (#{align_signal(data_unzip,q_mark=false)})
);
"
    end
    
    public

    def self.data_uncompress(
        asize:8,
        lsize:8,
        data_zip:"data_zip",
        data_unzip:"data_unzip",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [data_zip,data_unzip].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && data_unzip.eql?("data_unzip")
            if up_stream.is_a? DataInf_C
                down_stream = up_stream.copy
            else
                down_stream = data_zip.copy
            end
            return_stream = down_stream
        end

        
        if up_stream.nil? && data_zip.eql?("data_zip")
            if down_stream.is_a? DataInf_C
                up_stream = down_stream.copy
            else
                up_stream = data_unzip.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? DataInf_C
            down_stream.data_uncompress(
                asize:asize,
                lsize:lsize,
                data_zip:data_zip,
                data_unzip:data_unzip,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif data_unzip.is_a? DataInf_C
            data_unzip.data_uncompress(
                asize:asize,
                lsize:lsize,
                data_zip:data_zip,
                data_unzip:data_unzip,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.DataInf_C_NC.data_uncompress(
                asize:asize,
                lsize:lsize,
                data_zip:data_zip,
                data_unzip:data_unzip,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

