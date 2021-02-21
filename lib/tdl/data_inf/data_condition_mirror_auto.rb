
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class DataInf_C


    def data_condition_mirror(
        h:0,
        l:0,
        condition_data:"condition_data",
        data_in:"data_in",
        data_out:"data_out",
        data_mirror:"data_mirror",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('data_condition_mirror','../../axi/data_interface/data_inf_c/data_condition_mirror.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['data_condition_mirror','../../axi/data_interface/data_inf_c/data_condition_mirror.sv'])
        return_stream = self
        
        data_in = DataInf_C.same_name_socket(:from_up,mix=true,data_in,nil,belong_to_module) unless data_in.is_a? String
        data_out = DataInf_C.same_name_socket(:to_down,mix=true,data_out,nil,belong_to_module) unless data_out.is_a? String
        data_mirror = DataInf_C.same_name_socket(:to_down,mix=true,data_mirror,nil,belong_to_module) unless data_mirror.is_a? String
        
        if up_stream.nil? && data_in.eql?("data_in") && (!(data_out.eql?("data_out")) || !down_stream.nil?)
            # up_stream = self.copy(name:"data_in")
            # return_stream = up_stream
            data_out = down_stream if down_stream
            return down_stream.data_condition_mirror(data_in:self)
        end

        data_in = up_stream if up_stream
        unless self.eql? belong_to_module.DataInf_C_NC
            data_out = self
        else
            if down_stream
                data_out = down_stream
            end
        end


        belong_to_module.DataInf_C_draw << data_condition_mirror_draw(
            h:h,
            l:l,
            condition_data:condition_data,
            data_in:data_in,
            data_out:data_out,
            data_mirror:data_mirror,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def data_condition_mirror_draw(
        h:0,
        l:0,
        condition_data:"condition_data",
        data_in:"data_in",
        data_out:"data_out",
        data_mirror:"data_mirror",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            h,
            l,
            condition_data,
            data_in,
            data_out,
            data_mirror
        )
        instance_name = "data_condition_mirror_#{signal}_inst"
"
// FilePath:::../../axi/data_interface/data_inf_c/data_condition_mirror.sv
data_condition_mirror#(
    .H    (#{align_signal(h)}),
    .L    (#{align_signal(l)})
) #{instance_name}(
/*  input  [H:L]     */ .condition_data (#{align_signal(condition_data,q_mark=false)}),
/*  data_inf_c.slaver*/ .data_in        (#{align_signal(data_in,q_mark=false)}),
/*  data_inf_c.master*/ .data_out       (#{align_signal(data_out,q_mark=false)}),
/*  data_inf_c.master*/ .data_mirror    (#{align_signal(data_mirror,q_mark=false)})
);
"
    end
    
    public

    def self.data_condition_mirror(
        h:0,
        l:0,
        condition_data:"condition_data",
        data_in:"data_in",
        data_out:"data_out",
        data_mirror:"data_mirror",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [data_in,data_out,data_mirror].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && data_out.eql?("data_out")
            if up_stream.is_a? DataInf_C
                down_stream = up_stream.copy
            else
                down_stream = data_in.copy
            end
            return_stream = down_stream
        end

        
        if up_stream.nil? && data_in.eql?("data_in")
            if down_stream.is_a? DataInf_C
                up_stream = down_stream.copy
            else
                up_stream = data_out.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? DataInf_C
            down_stream.data_condition_mirror(
                h:h,
                l:l,
                condition_data:condition_data,
                data_in:data_in,
                data_out:data_out,
                data_mirror:data_mirror,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif data_out.is_a? DataInf_C
            data_out.data_condition_mirror(
                h:h,
                l:l,
                condition_data:condition_data,
                data_in:data_in,
                data_out:data_out,
                data_mirror:data_mirror,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.DataInf_C_NC.data_condition_mirror(
                h:h,
                l:l,
                condition_data:condition_data,
                data_in:data_in,
                data_out:data_out,
                data_mirror:data_mirror,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

