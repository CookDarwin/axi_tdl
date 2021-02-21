
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class DataInf_C


    def data_mirrors_verb(
        h:0,
        l:0,
        num:8,
        mode:"CDS_MODE",
        condition_data:"condition_data",
        data_in:"data_in",
        data_mirror:"data_mirror",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('data_mirrors_verb','../../axi/data_interface/data_inf_c/data_mirrors_verb.sv.bak')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['data_mirrors_verb','../../axi/data_interface/data_inf_c/data_mirrors_verb.sv.bak'])
        return_stream = self
        
        data_in = DataInf_C.same_name_socket(:from_up,mix=true,data_in,nil,belong_to_module) unless data_in.is_a? String
        data_mirror = DataInf_C.same_name_socket(:to_down,mix=false,data_mirror,nil,belong_to_module) unless data_mirror.is_a? String
        
        if up_stream.nil? && data_in.eql?("data_in") && (!(data_mirror.eql?("data_mirror")) || !down_stream.nil?)
            # up_stream = self.copy(name:"data_in")
            # return_stream = up_stream
            data_mirror = down_stream if down_stream
            return down_stream.data_mirrors_verb(data_in:self)
        end

        data_in = up_stream if up_stream
        unless self.eql? belong_to_module.DataInf_C_NC
            data_mirror = self
        else
            if down_stream
                data_mirror = down_stream
            end
        end


        belong_to_module.DataInf_C_draw << data_mirrors_verb_draw(
            h:h,
            l:l,
            num:num,
            mode:mode,
            condition_data:condition_data,
            data_in:data_in,
            data_mirror:data_mirror,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def data_mirrors_verb_draw(
        h:0,
        l:0,
        num:8,
        mode:"CDS_MODE",
        condition_data:"condition_data",
        data_in:"data_in",
        data_mirror:"data_mirror",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            h,
            l,
            num,
            mode,
            condition_data,
            data_in,
            data_mirror
        )
        instance_name = "data_mirrors_verb_#{signal}_inst"
"
// FilePath:::../../axi/data_interface/data_inf_c/data_mirrors_verb.sv.bak
data_mirrors_verb#(
    .H       (#{align_signal(h)}),
    .L       (#{align_signal(l)}),
    .NUM     (#{align_signal(num)}),
    .MODE    (#{align_signal(mode)})
) #{instance_name}(
/*  input  [H:L]     */ .condition_data (#{align_signal(condition_data,q_mark=false)}),
/*  data_inf_c.slaver*/ .data_in        (#{align_signal(data_in,q_mark=false)}),
/*  data_inf_c.master*/ .data_mirror    (#{align_signal(data_mirror,q_mark=false)})
);
"
    end
    
    public

    def self.data_mirrors_verb(
        h:0,
        l:0,
        num:8,
        mode:"CDS_MODE",
        condition_data:"condition_data",
        data_in:"data_in",
        data_mirror:"data_mirror",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [data_in,data_mirror].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && data_mirror.eql?("data_mirror")
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
                up_stream = data_mirror.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? DataInf_C
            down_stream.data_mirrors_verb(
                h:h,
                l:l,
                num:num,
                mode:mode,
                condition_data:condition_data,
                data_in:data_in,
                data_mirror:data_mirror,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif data_mirror.is_a? DataInf_C
            data_mirror.data_mirrors_verb(
                h:h,
                l:l,
                num:num,
                mode:mode,
                condition_data:condition_data,
                data_in:data_in,
                data_mirror:data_mirror,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.DataInf_C_NC.data_mirrors_verb(
                h:h,
                l:l,
                num:num,
                mode:mode,
                condition_data:condition_data,
                data_in:data_in,
                data_mirror:data_mirror,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

