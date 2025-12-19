
#2017-07-18 14:34:28 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def axi_streams_scaler(mode:"BOTH",cut_or_combin_body:"ON",dsize:8,new_body_len:"new_body_len",head_inf:"head_inf",body_inf:"body_inf",end_inf:"end_inf",m00:"m00",up_stream:nil,down_stream:nil)
        return_stream = self

        if up_stream==nil && body_inf=="body_inf"
            up_stream = self.copy(name:"body_inf")
            return_stream = up_stream
        end

        body_inf = up_stream if up_stream
        m00 = self

        $_draw = lambda { axi_streams_scaler_draw(mode:mode,cut_or_combin_body:cut_or_combin_body,dsize:dsize,new_body_len:new_body_len,head_inf:head_inf,body_inf:body_inf,end_inf:end_inf,m00:m00,up_stream:up_stream,down_stream:down_stream) }
        @correlation_proc += $_draw.call
        return return_stream
    end

    def axi_streams_scaler_draw(mode:"BOTH",cut_or_combin_body:"ON",dsize:8,new_body_len:"new_body_len",head_inf:"head_inf",body_inf:"body_inf",end_inf:"end_inf",m00:"m00",up_stream:nil,down_stream:nil)
        large_name_len(mode,cut_or_combin_body,dsize,new_body_len,head_inf,body_inf,end_inf,m00)
"
axi_streams_scaler#(
    .MODE                  (#{align_signal(mode)}),
    .CUT_OR_COMBIN_BODY    (#{align_signal(cut_or_combin_body)}),
    .DSIZE                 (#{align_signal(dsize,q_mark=false)})
) axi_streams_scaler_#{signal}_inst(
/*  input  [15:0]        */ .new_body_len (#{align_signal(new_body_len,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .head_inf     (#{align_signal(head_inf,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .body_inf     (#{align_signal(body_inf,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .end_inf      (#{align_signal(end_inf,q_mark=false)}),
/*  axi_stream_inf.master*/ .m00          (#{align_signal(m00,q_mark=false)})
);
"
    end

    def self.axi_streams_scaler(mode:"BOTH",cut_or_combin_body:"ON",dsize:8,new_body_len:"new_body_len",head_inf:"head_inf",body_inf:"body_inf",end_inf:"end_inf",m00:"m00",up_stream:nil,down_stream:nil)
        return_stream = nil

        if down_stream==nil && m00=="m00"
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy(name:"m00")
            else
                down_stream = body_inf.copy(name:"m00")
            end
            return_stream = down_stream
        end


        if up_stream==nil && body_inf=="body_inf"
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy(name:"body_inf")
            else
                up_stream = m00.copy(name:"body_inf")
            end
            return_stream = up_stream
        end


        if down_stream.is_a? AxiStream
            down_stream.axi_streams_scaler(mode:mode,cut_or_combin_body:cut_or_combin_body,dsize:dsize,new_body_len:new_body_len,head_inf:head_inf,body_inf:body_inf,end_inf:end_inf,m00:m00,up_stream:up_stream,down_stream:down_stream)
        elsif m00.is_a? AxiStream
            m00.axi_streams_scaler(mode:mode,cut_or_combin_body:cut_or_combin_body,dsize:dsize,new_body_len:new_body_len,head_inf:head_inf,body_inf:body_inf,end_inf:end_inf,m00:m00,up_stream:up_stream,down_stream:down_stream)
        else
            NC.axi_streams_scaler(mode:mode,cut_or_combin_body:cut_or_combin_body,dsize:dsize,new_body_len:new_body_len,head_inf:head_inf,body_inf:body_inf,end_inf:end_inf,m00:m00,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end


end


class TdlTest

    def self.test_axi_streams_scaler
        c0 = Clock.new(name:"axi_streams_scaler_clk",freqM:148.5)
        r0 = Reset.new(name:"axi_streams_scaler_rst_n",active:"low")

        Parameter.new(name:"mode",value:"BOTH")
        Parameter.new(name:"cut_or_combin_body",value:"ON")
        Parameter.new(name:"dsize",value:8)
        Logic.new(name:"new_body_len")
        AxiStream.new(name:"head_inf",clock:c0,reset:r0)
        AxiStream.new(name:"body_inf",clock:c0,reset:r0)
        AxiStream.new(name:"end_inf",clock:c0,reset:r0)
        AxiStream.new(name:"m00",clock:c0,reset:r0)
        up_stream = body_inf
        down_stream = m00
        AxiStream.axi_streams_scaler(mode:mode,cut_or_combin_body:cut_or_combin_body,dsize:dsize,new_body_len:new_body_len,head_inf:head_inf,body_inf:body_inf,end_inf:end_inf,m00:m00)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axi_streams_scaler(mode:"BOTH",
        cut_or_combin_body:"ON",
        dsize:8,
        new_body_len:"new_body_len",
        head_inf:"head_inf",
        body_inf:"body_inf",
        end_inf:"end_inf",
        m00:"m00")
        hash = TdlHash.new

        unless mode.is_a? Hash
            # hash.new_index(:mode) = mode
            if mode.is_a? BaseElm
                hash.[]=(:mode,mode,true)
            else
                hash.[]=(:mode,mode,false)
            end
        else
            # hash.new_index(:mode)= lambda { a = Parameter.new(mode);a.name = "mode";return a }
            # hash[:mode] = lambda { a = Parameter.new(mode);a.name = "mode";return a }
            lam = lambda {
                a = Parameter.new(mode)
                unless mode[:name]
                    a.name = "mode"
                end
                return a }
            hash.[]=(:mode,lam,false)
        end


        unless cut_or_combin_body.is_a? Hash
            # hash.new_index(:cut_or_combin_body) = cut_or_combin_body
            if cut_or_combin_body.is_a? BaseElm
                hash.[]=(:cut_or_combin_body,cut_or_combin_body,true)
            else
                hash.[]=(:cut_or_combin_body,cut_or_combin_body,false)
            end
        else
            # hash.new_index(:cut_or_combin_body)= lambda { a = Parameter.new(cut_or_combin_body);a.name = "cut_or_combin_body";return a }
            # hash[:cut_or_combin_body] = lambda { a = Parameter.new(cut_or_combin_body);a.name = "cut_or_combin_body";return a }
            lam = lambda {
                a = Parameter.new(cut_or_combin_body)
                unless cut_or_combin_body[:name]
                    a.name = "cut_or_combin_body"
                end
                return a }
            hash.[]=(:cut_or_combin_body,lam,false)
        end


        unless dsize.is_a? Hash
            # hash.new_index(:dsize) = dsize
            if dsize.is_a? BaseElm
                hash.[]=(:dsize,dsize,true)
            else
                hash.[]=(:dsize,dsize,false)
            end
        else
            # hash.new_index(:dsize)= lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            # hash[:dsize] = lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            lam = lambda {
                a = Parameter.new(dsize)
                unless dsize[:name]
                    a.name = "dsize"
                end
                return a }
            hash.[]=(:dsize,lam,false)
        end


        unless new_body_len.is_a? Hash
            # hash.new_index(:new_body_len) = new_body_len
            if new_body_len.is_a? BaseElm
                hash.[]=(:new_body_len,new_body_len,true)
            else
                hash.[]=(:new_body_len,new_body_len,false)
            end
        else
            # hash.new_index(:new_body_len)= lambda { a = Logic.new(new_body_len);a.name = "new_body_len";return a }
            # hash[:new_body_len] = lambda { a = Logic.new(new_body_len);a.name = "new_body_len";return a }
            lam = lambda {
                a = Logic.new(new_body_len)
                unless new_body_len[:name]
                    a.name = "new_body_len"
                end
                return a }
            hash.[]=(:new_body_len,lam,false)
        end


        unless head_inf.is_a? Hash
            # hash.new_index(:head_inf) = head_inf
            if head_inf.is_a? BaseElm
                hash.[]=(:head_inf,head_inf,true)
            else
                hash.[]=(:head_inf,head_inf,false)
            end
        else
            # hash.new_index(:head_inf)= lambda { a = AxiStream.new(head_inf);a.name = "head_inf";return a }
            # hash[:head_inf] = lambda { a = AxiStream.new(head_inf);a.name = "head_inf";return a }
            lam = lambda {
                a = AxiStream.new(head_inf)
                unless head_inf[:name]
                    a.name = "head_inf"
                end
                return a }
            hash.[]=(:head_inf,lam,false)
        end


        unless body_inf.is_a? Hash
            # hash.new_index(:body_inf) = body_inf
            if body_inf.is_a? BaseElm
                hash.[]=(:body_inf,body_inf,true)
            else
                hash.[]=(:body_inf,body_inf,false)
            end
        else
            # hash.new_index(:body_inf)= lambda { a = AxiStream.new(body_inf);a.name = "body_inf";return a }
            # hash[:body_inf] = lambda { a = AxiStream.new(body_inf);a.name = "body_inf";return a }
            lam = lambda {
                a = AxiStream.new(body_inf)
                unless body_inf[:name]
                    a.name = "body_inf"
                end
                return a }
            hash.[]=(:body_inf,lam,false)
        end


        unless end_inf.is_a? Hash
            # hash.new_index(:end_inf) = end_inf
            if end_inf.is_a? BaseElm
                hash.[]=(:end_inf,end_inf,true)
            else
                hash.[]=(:end_inf,end_inf,false)
            end
        else
            # hash.new_index(:end_inf)= lambda { a = AxiStream.new(end_inf);a.name = "end_inf";return a }
            # hash[:end_inf] = lambda { a = AxiStream.new(end_inf);a.name = "end_inf";return a }
            lam = lambda {
                a = AxiStream.new(end_inf)
                unless end_inf[:name]
                    a.name = "end_inf"
                end
                return a }
            hash.[]=(:end_inf,lam,false)
        end


        unless m00.is_a? Hash
            # hash.new_index(:m00) = m00
            if m00.is_a? BaseElm
                hash.[]=(:m00,m00,true)
            else
                hash.[]=(:m00,m00,false)
            end
        else
            # hash.new_index(:m00)= lambda { a = AxiStream.new(m00);a.name = "m00";return a }
            # hash[:m00] = lambda { a = AxiStream.new(m00);a.name = "m00";return a }
            lam = lambda {
                a = AxiStream.new(m00)
                unless m00[:name]
                    a.name = "m00"
                end
                return a }
            hash.[]=(:m00,lam,false)
        end


        Tdl.module_stack  << lambda {
            hash.each do |k,v|
                if v.is_a? Proc
                    hash.[]=(k,v.call,false)
                elsif v.is_a? Array
                    unless v.empty?
                        if v[0].is_a? Axi4
                            cm = v[0].copy(name:k,idsize:Math.log2(v.length).ceil+v[0].idsize)
                        else
                            cm = v[0].copy(name:k)
                        end
                        cm.<<(*v)
                        # hash[k] = cm
                        hash.[]=(k,cm)
                    else
                        hash.[]=(k,nil,false)
                    end
                else
                    # hash[k] = v
                end
            end
            hash.check_use("axi_streams_scaler")
            AxiStream.axi_streams_scaler(hash)
        }
        return hash
    end
end
