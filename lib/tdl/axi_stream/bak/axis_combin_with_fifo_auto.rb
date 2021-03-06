
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_combin_with_fifo(mode:"BOTH",cut_or_combin_body:"ON",new_body_len:"new_body_len",head_inf:"head_inf",body_inf:"body_inf",end_inf:"end_inf",m00:"m00",up_stream:nil,down_stream:nil)

        Tdl.add_to_all_file_paths(['axis_combin_with_fifo','../../axi/AXI_stream/axis_combin_with_fifo.sv'])
        return_stream = self
        
        head_inf = AxiStream.same_name_socket(:from_up,mix=true,head_inf) unless head_inf.is_a? String
        body_inf = AxiStream.same_name_socket(:from_up,mix=true,body_inf) unless body_inf.is_a? String
        end_inf = AxiStream.same_name_socket(:from_up,mix=true,end_inf) unless end_inf.is_a? String
        m00 = AxiStream.same_name_socket(:to_down,mix=true,m00) unless m00.is_a? String
        
        if up_stream==nil && body_inf=="body_inf"
            up_stream = self.copy(name:"body_inf")
            return_stream = up_stream
        end

        body_inf = up_stream if up_stream
        m00 = self unless self==AxiStream.NC

         @instance_draw_stack << lambda { axis_combin_with_fifo_draw(mode:mode,cut_or_combin_body:cut_or_combin_body,new_body_len:new_body_len,head_inf:head_inf,body_inf:body_inf,end_inf:end_inf,m00:m00,up_stream:up_stream,down_stream:down_stream) }
        return return_stream
    end

    def axis_combin_with_fifo_draw(mode:"BOTH",cut_or_combin_body:"ON",new_body_len:"new_body_len",head_inf:"head_inf",body_inf:"body_inf",end_inf:"end_inf",m00:"m00",up_stream:nil,down_stream:nil)

        large_name_len(mode,cut_or_combin_body,new_body_len,head_inf,body_inf,end_inf,m00)
"
// FilePath:::../../axi/AXI_stream/axis_combin_with_fifo.sv
axis_combin_with_fifo#(
    .MODE                  (#{align_signal(mode)}),
    .CUT_OR_COMBIN_BODY    (#{align_signal(cut_or_combin_body)})
) axis_combin_with_fifo_#{signal}_inst(
/*  input  [15:0]        */ .new_body_len (#{align_signal(new_body_len,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .head_inf     (#{align_signal(head_inf,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .body_inf     (#{align_signal(body_inf,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .end_inf      (#{align_signal(end_inf,q_mark=false)}),
/*  axi_stream_inf.master*/ .m00          (#{align_signal(m00,q_mark=false)})
);
"
    end
    
    def self.axis_combin_with_fifo(mode:"BOTH",cut_or_combin_body:"ON",new_body_len:"new_body_len",head_inf:"head_inf",body_inf:"body_inf",end_inf:"end_inf",m00:"m00",up_stream:nil,down_stream:nil)
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
            down_stream.axis_combin_with_fifo(mode:mode,cut_or_combin_body:cut_or_combin_body,new_body_len:new_body_len,head_inf:head_inf,body_inf:body_inf,end_inf:end_inf,m00:m00,up_stream:up_stream,down_stream:down_stream)
        elsif m00.is_a? AxiStream
            m00.axis_combin_with_fifo(mode:mode,cut_or_combin_body:cut_or_combin_body,new_body_len:new_body_len,head_inf:head_inf,body_inf:body_inf,end_inf:end_inf,m00:m00,up_stream:up_stream,down_stream:down_stream)
        else
            AxiStream.NC.axis_combin_with_fifo(mode:mode,cut_or_combin_body:cut_or_combin_body,new_body_len:new_body_len,head_inf:head_inf,body_inf:body_inf,end_inf:end_inf,m00:m00,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_axis_combin_with_fifo
        c0 = Clock.new(name:"axis_combin_with_fifo_clk",freqM:148.5)
        r0 = Reset.new(name:"axis_combin_with_fifo_rst_n",active:"low")

        mode = Parameter.new(name:"mode",value:"BOTH")
        cut_or_combin_body = Parameter.new(name:"cut_or_combin_body",value:"ON")
        new_body_len = Logic.new(name:"new_body_len")
        head_inf = AxiStream.new(name:"head_inf",clock:c0,reset:r0)
        body_inf = AxiStream.new(name:"body_inf",clock:c0,reset:r0)
        end_inf = AxiStream.new(name:"end_inf",clock:c0,reset:r0)
        m00 = AxiStream.new(name:"m00",clock:c0,reset:r0)
        up_stream = body_inf
        down_stream = m00
        AxiStream.axis_combin_with_fifo(mode:mode,cut_or_combin_body:cut_or_combin_body,new_body_len:new_body_len,head_inf:head_inf,body_inf:body_inf,end_inf:end_inf,m00:m00)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axis_combin_with_fifo(
        mode:"BOTH",
        cut_or_combin_body:"ON",
        new_body_len:"new_body_len",
        head_inf:"head_inf",
        body_inf:"body_inf",
        end_inf:"end_inf",
        m00:"m00")
        hash = TdlHash.new
        
        unless mode.is_a? Hash
            hash.case_record(:mode,mode)
        else
            # hash.new_index(:mode)= lambda { a = Parameter.new(mode);a.name = "mode";return a }
            # hash[:mode] = lambda { a = Parameter.new(mode);a.name = "mode";return a }
            raise TdlError.new('axis_combin_with_fifo Parameter mode TdlHash cant include Proc') if mode.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(mode)
                unless mode[:name]
                    a.name = "mode"
                end
                return a }
            hash.[]=(:mode,lam,false)
        end
                

        unless cut_or_combin_body.is_a? Hash
            hash.case_record(:cut_or_combin_body,cut_or_combin_body)
        else
            # hash.new_index(:cut_or_combin_body)= lambda { a = Parameter.new(cut_or_combin_body);a.name = "cut_or_combin_body";return a }
            # hash[:cut_or_combin_body] = lambda { a = Parameter.new(cut_or_combin_body);a.name = "cut_or_combin_body";return a }
            raise TdlError.new('axis_combin_with_fifo Parameter cut_or_combin_body TdlHash cant include Proc') if cut_or_combin_body.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(cut_or_combin_body)
                unless cut_or_combin_body[:name]
                    a.name = "cut_or_combin_body"
                end
                return a }
            hash.[]=(:cut_or_combin_body,lam,false)
        end
                

        unless new_body_len.is_a? Hash
            hash.case_record(:new_body_len,new_body_len)
        else
            # hash.new_index(:new_body_len)= lambda { a = Logic.new(new_body_len);a.name = "new_body_len";return a }
            # hash[:new_body_len] = lambda { a = Logic.new(new_body_len);a.name = "new_body_len";return a }
            raise TdlError.new('axis_combin_with_fifo Logic new_body_len TdlHash cant include Proc') if new_body_len.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(new_body_len)
                unless new_body_len[:name]
                    a.name = "new_body_len"
                end
                return a }
            hash.[]=(:new_body_len,lam,false)
        end
                

        unless head_inf.is_a? Hash
            hash.case_record(:head_inf,head_inf)
        else
            # hash.new_index(:head_inf)= lambda { a = AxiStream.new(head_inf);a.name = "head_inf";return a }
            # hash[:head_inf] = lambda { a = AxiStream.new(head_inf);a.name = "head_inf";return a }
            raise TdlError.new('axis_combin_with_fifo AxiStream head_inf TdlHash cant include Proc') if head_inf.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(head_inf)
                unless head_inf[:name]
                    a.name = "head_inf"
                end
                return a }
            hash.[]=(:head_inf,lam,false)
        end
                

        unless body_inf.is_a? Hash
            hash.case_record(:body_inf,body_inf)
        else
            # hash.new_index(:body_inf)= lambda { a = AxiStream.new(body_inf);a.name = "body_inf";return a }
            # hash[:body_inf] = lambda { a = AxiStream.new(body_inf);a.name = "body_inf";return a }
            raise TdlError.new('axis_combin_with_fifo AxiStream body_inf TdlHash cant include Proc') if body_inf.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(body_inf)
                unless body_inf[:name]
                    a.name = "body_inf"
                end
                return a }
            hash.[]=(:body_inf,lam,false)
        end
                

        unless end_inf.is_a? Hash
            hash.case_record(:end_inf,end_inf)
        else
            # hash.new_index(:end_inf)= lambda { a = AxiStream.new(end_inf);a.name = "end_inf";return a }
            # hash[:end_inf] = lambda { a = AxiStream.new(end_inf);a.name = "end_inf";return a }
            raise TdlError.new('axis_combin_with_fifo AxiStream end_inf TdlHash cant include Proc') if end_inf.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(end_inf)
                unless end_inf[:name]
                    a.name = "end_inf"
                end
                return a }
            hash.[]=(:end_inf,lam,false)
        end
                

        unless m00.is_a? Hash
            hash.case_record(:m00,m00)
        else
            # hash.new_index(:m00)= lambda { a = AxiStream.new(m00);a.name = "m00";return a }
            # hash[:m00] = lambda { a = AxiStream.new(m00);a.name = "m00";return a }
            raise TdlError.new('axis_combin_with_fifo AxiStream m00 TdlHash cant include Proc') if m00.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(m00)
                unless m00[:name]
                    a.name = "m00"
                end
                return a }
            hash.[]=(:m00,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:axis_combin_with_fifo)
        hash.open_error = true
        return hash
    end
end
