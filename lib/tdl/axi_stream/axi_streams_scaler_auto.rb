
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def axi_streams_scaler(
        mode:"BOTH",
        cut_or_combin_body:"ON",
        dsize:8,
        new_body_len:"new_body_len",
        head_inf:"head_inf",
        body_inf:"body_inf",
        end_inf:"end_inf",
        m00:"m00",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('axi_streams_scaler','../../axi/AXI_stream/axi_streams_scaler.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axi_streams_scaler','../../axi/AXI_stream/axi_streams_scaler.sv'])
        return_stream = self
        
        head_inf = AxiStream.same_name_socket(:from_up,mix=true,head_inf,nil,belong_to_module) unless head_inf.is_a? String
        body_inf = AxiStream.same_name_socket(:from_up,mix=true,body_inf,nil,belong_to_module) unless body_inf.is_a? String
        end_inf = AxiStream.same_name_socket(:from_up,mix=true,end_inf,nil,belong_to_module) unless end_inf.is_a? String
        m00 = AxiStream.same_name_socket(:to_down,mix=true,m00,nil,belong_to_module) unless m00.is_a? String
        
        if up_stream.nil? && body_inf.eql?("body_inf") && (!(m00.eql?("m00")) || !down_stream.nil?)
            # up_stream = self.copy(name:"body_inf")
            # return_stream = up_stream
            m00 = down_stream if down_stream
            return down_stream.axi_streams_scaler(body_inf:self)
        end

        body_inf = up_stream if up_stream
        unless self.eql? belong_to_module.AxiStream_NC
            m00 = self
        else
            if down_stream
                m00 = down_stream
            end
        end


        belong_to_module.AxiStream_draw << axi_streams_scaler_draw(
            mode:mode,
            cut_or_combin_body:cut_or_combin_body,
            dsize:dsize,
            new_body_len:new_body_len,
            head_inf:head_inf,
            body_inf:body_inf,
            end_inf:end_inf,
            m00:m00,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def axi_streams_scaler_draw(
        mode:"BOTH",
        cut_or_combin_body:"ON",
        dsize:8,
        new_body_len:"new_body_len",
        head_inf:"head_inf",
        body_inf:"body_inf",
        end_inf:"end_inf",
        m00:"m00",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            mode,
            cut_or_combin_body,
            dsize,
            new_body_len,
            head_inf,
            body_inf,
            end_inf,
            m00
        )
        instance_name = "axi_streams_scaler_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axi_streams_scaler.sv
axi_streams_scaler#(
    .MODE                  (#{align_signal(mode)}),
    .CUT_OR_COMBIN_BODY    (#{align_signal(cut_or_combin_body)}),
    .DSIZE                 (#{align_signal(dsize)})
) #{instance_name}(
/*  input  [15:0]        */ .new_body_len (#{align_signal(new_body_len,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .head_inf     (#{align_signal(head_inf,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .body_inf     (#{align_signal(body_inf,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .end_inf      (#{align_signal(end_inf,q_mark=false)}),
/*  axi_stream_inf.master*/ .m00          (#{align_signal(m00,q_mark=false)})
);
"
    end
    
    public

    def self.axi_streams_scaler(
        mode:"BOTH",
        cut_or_combin_body:"ON",
        dsize:8,
        new_body_len:"new_body_len",
        head_inf:"head_inf",
        body_inf:"body_inf",
        end_inf:"end_inf",
        m00:"m00",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [head_inf,body_inf,end_inf,m00].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && m00.eql?("m00")
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy
            else
                down_stream = body_inf.copy
            end
            return_stream = down_stream
        end

        
        if up_stream.nil? && body_inf.eql?("body_inf")
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy
            else
                up_stream = m00.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axi_streams_scaler(
                mode:mode,
                cut_or_combin_body:cut_or_combin_body,
                dsize:dsize,
                new_body_len:new_body_len,
                head_inf:head_inf,
                body_inf:body_inf,
                end_inf:end_inf,
                m00:m00,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif m00.is_a? AxiStream
            m00.axi_streams_scaler(
                mode:mode,
                cut_or_combin_body:cut_or_combin_body,
                dsize:dsize,
                new_body_len:new_body_len,
                head_inf:head_inf,
                body_inf:body_inf,
                end_inf:end_inf,
                m00:m00,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.AxiStream_NC.axi_streams_scaler(
                mode:mode,
                cut_or_combin_body:cut_or_combin_body,
                dsize:dsize,
                new_body_len:new_body_len,
                head_inf:head_inf,
                body_inf:body_inf,
                end_inf:end_inf,
                m00:m00,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

