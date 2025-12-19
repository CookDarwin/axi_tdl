
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class DataInf_C


    def data_c_cache(
        data_in:"data_in",
        data_out:"data_out",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('data_c_cache','../../axi/data_interface/data_inf_c/data_c_cache.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['data_c_cache','../../axi/data_interface/data_inf_c/data_c_cache.sv'])
        return_stream = self
        
        data_in = DataInf_C.same_name_socket(:from_up,mix=true,data_in,nil,belong_to_module) unless data_in.is_a? String
        data_out = DataInf_C.same_name_socket(:to_down,mix=true,data_out,nil,belong_to_module) unless data_out.is_a? String
        
        if up_stream.nil? && data_in.eql?("data_in") && (!(data_out.eql?("data_out")) || !down_stream.nil?)
            # up_stream = self.copy(name:"data_in")
            # return_stream = up_stream
            data_out = down_stream if down_stream
            return down_stream.data_c_cache(data_in:self)
        end

        data_in = up_stream if up_stream
        unless self.eql? belong_to_module.DataInf_C_NC
            data_out = self
        else
            if down_stream
                data_out = down_stream
            end
        end


        belong_to_module.DataInf_C_draw << data_c_cache_draw(
            data_in:data_in,
            data_out:data_out,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def data_c_cache_draw(
        data_in:"data_in",
        data_out:"data_out",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            data_in,
            data_out
        )
        instance_name = "data_c_cache_#{signal}_inst"
"
// FilePath:::../../axi/data_interface/data_inf_c/data_c_cache.sv
data_c_cache #{instance_name}(
/*  data_inf_c.slaver*/ .data_in  (#{align_signal(data_in,q_mark=false)}),
/*  data_inf_c.master*/ .data_out (#{align_signal(data_out,q_mark=false)})
);
"
    end
    
    public

    def self.data_c_cache(
        data_in:"data_in",
        data_out:"data_out",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil

        ms = [data_in,data_out,up_stream,down_stream].map do |e|
            if e.respond_to? :belong_to_module
                e.belong_to_module
            else 
                nil 
            end
        end
        belong_to_module = ms.compact.first unless belong_to_module
        
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
            down_stream.data_c_cache(
                data_in:data_in,
                data_out:data_out,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif data_out.is_a? DataInf_C
            data_out.data_c_cache(
                data_in:data_in,
                data_out:data_out,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.DataInf_C_NC.data_c_cache(
                data_in:data_in,
                data_out:data_out,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

