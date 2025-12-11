
#2017-07-31 13:06:50 +0800
#require_relative ".././tdl"
# require_relative '..\..\tdl\tdl'

class DataInf_C


    def data_mirrors(h:0,l:0,mode:"CDS_MODE",condition_data:"condition_data",data_in:"data_in",data_mirror:"data_mirror",up_stream:nil,down_stream:nil)
        return_stream = self

        if data_mirror.is_a? DataInf_C
            data_mirror = [data_mirror]
        elsif data_mirror.is_a? DataInf
            data_mirror = [data_mirror.to_data_inf_c()]
        end

        unless data_mirror.is_a? Array
            raise TdlError.new("DATA_MIRROR must a Array")
        end

        num = data_mirror.length

        data_in = DataInf_C.same_name_socket(:from_up,mix=true,data_in)

        data_mirror = DataInf_C.same_name_socket(:to_down,mix=false,data_mirror)

        # puts data_mirror.signal
        if up_stream==nil && data_in=="data_in"
            up_stream = self.copy(name:"data_in")
            return_stream = up_stream
        end

        data_in = up_stream if up_stream
        data_mirror = self unless self==belong_to_module.DataInf_C_NC

        belong_to_module.DataInf_C_draw << data_mirrors_draw(h:h,l:l,num:num,mode:mode,condition_data:condition_data,data_in:data_in,data_mirror:data_mirror,up_stream:up_stream,down_stream:down_stream)

        return return_stream
    end

    def data_mirrors_draw(h:0,l:0,num:8,mode:"CDS_MODE",condition_data:"condition_data",data_in:"data_in",data_mirror:"data_mirror",up_stream:nil,down_stream:nil)
        large_name_len(h,l,num,mode,condition_data,data_in,data_mirror)
"
data_mirrors#(
    .H       (#{align_signal(h)}),
    .L       (#{align_signal(l)}),
    .NUM     (#{align_signal(num)}),
    .MODE    (#{align_signal(mode)})
) data_mirrors_#{signal}_inst(
/*  input  [H:L]     */ .condition_data (#{align_signal(condition_data,q_mark=false)}),
/*  data_inf_c.slaver*/ .data_in        (#{align_signal(data_in,q_mark=false)}),
/*  data_inf_c.master*/ .data_mirror    (#{align_signal(data_mirror,q_mark=false)})
);
"
    end

    def self.data_mirrors(h:0,l:0,mode:"CDS_MODE",condition_data:"condition_data",data_in:"data_in",data_mirror:"data_mirror",up_stream:nil,down_stream:nil,belong_to_module:nil)
        return_stream = nil
        belong_to_module = [data_in,data_mirror].first.belong_to_module unless belong_to_module
        # p data_mirror
        if down_stream==nil && data_mirror=="data_mirror"
            if up_stream.is_a? DataInf_C
                down_stream = up_stream.copy(name:"data_mirror")
            else
                down_stream = data_in.copy(name:"data_mirror")
            end
            return_stream = down_stream
        end


        if up_stream==nil && data_in=="data_in"
            if down_stream.is_a? DataInf_C
                up_stream = down_stream.copy(name:"data_in")
            else
                up_stream = data_mirror.copy(name:"data_in")
            end
            return_stream = up_stream
        end

        if down_stream.is_a? DataInf_C
            down_stream.data_mirrors(h:h,l:l,mode:mode,condition_data:condition_data,data_in:data_in,data_mirror:data_mirror,up_stream:up_stream,down_stream:down_stream)
        elsif data_mirror.is_a? DataInf_C
            data_mirror.data_mirrors(h:h,l:l,mode:mode,condition_data:condition_data,data_in:data_in,data_mirror:data_mirror,up_stream:up_stream,down_stream:down_stream)
        else
            belong_to_module.DataInf_C_NC.data_mirrors(h:h,l:l,mode:mode,condition_data:condition_data,data_in:data_in,data_mirror:data_mirror,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end


end
