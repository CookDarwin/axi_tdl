
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def _axi_stream_interconnect_s2m(num:8,addr:"addr",s00:"s00",m00:"m00")

        Tdl.add_to_all_file_paths(['axi_stream_interconnect_s2m','../../axi/AXI_stream/axi_stream_interconnect_S2M.sv'])
        return_stream = self
        
        s00 = AxiStream.same_name_socket(:from_up,mix=true,s00) unless s00.is_a? String
        m00 = AxiStream.same_name_socket(:to_down,mix=false,m00) unless m00.is_a? String
        
        
        

         @instance_draw_stack << lambda { _axi_stream_interconnect_s2m_draw(num:num,addr:addr,s00:s00,m00:m00) }
        return return_stream
    end

    def _axi_stream_interconnect_s2m_draw(num:8,addr:"addr",s00:"s00",m00:"m00")

        large_name_len(num,addr,s00,m00)
"
// FilePath:::../../axi/AXI_stream/axi_stream_interconnect_S2M.sv
axi_stream_interconnect_S2M#(
    .NUM    (#{align_signal(num)})
) axi_stream_interconnect_S2M_#{signal}_inst(
/*  input  [NSIZE-1:0]   */ .addr (#{align_signal(addr,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .s00  (#{align_signal(s00,q_mark=false)}),
/*  axi_stream_inf.master*/ .m00  (#{align_signal(m00,q_mark=false)})
);
"
    end
    
    def self.axi_stream_interconnect_s2m(num:8,addr:"addr",s00:"s00",m00:"m00")
        return_stream = nil
        
        
        AxiStream.NC._axi_stream_interconnect_s2m(num:num,addr:addr,s00:s00,m00:m00)
        return return_stream
    end
        

end


class TdlTest

    def self.test_axi_stream_interconnect_s2m
        c0 = Clock.new(name:"axi_stream_interconnect_s2m_clk",freqM:148.5)
        r0 = Reset.new(name:"axi_stream_interconnect_s2m_rst_n",active:"low")

        num = Parameter.new(name:"num",value:8)
        addr = Logic.new(name:"addr")
        s00 = AxiStream.new(name:"s00",clock:c0,reset:r0)
        m00 = AxiStream.new(name:"m00",clock:c0,reset:r0)
        
        
        AxiStream.axi_stream_interconnect_s2m(num:num,addr:addr,s00:s00,m00:m00)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axi_stream_interconnect_s2m(
        num:8,
        addr:"addr",
        s00:"s00",
        m00:"m00")
        hash = TdlHash.new
        
        unless num.is_a? Hash
            hash.case_record(:num,num)
        else
            # hash.new_index(:num)= lambda { a = Parameter.new(num);a.name = "num";return a }
            # hash[:num] = lambda { a = Parameter.new(num);a.name = "num";return a }
            raise TdlError.new('axi_stream_interconnect_s2m Parameter num TdlHash cant include Proc') if num.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(num)
                unless num[:name]
                    a.name = "num"
                end
                return a }
            hash.[]=(:num,lam,false)
        end
                

        unless addr.is_a? Hash
            hash.case_record(:addr,addr)
        else
            # hash.new_index(:addr)= lambda { a = Logic.new(addr);a.name = "addr";return a }
            # hash[:addr] = lambda { a = Logic.new(addr);a.name = "addr";return a }
            raise TdlError.new('axi_stream_interconnect_s2m Logic addr TdlHash cant include Proc') if addr.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(addr)
                unless addr[:name]
                    a.name = "addr"
                end
                return a }
            hash.[]=(:addr,lam,false)
        end
                

        unless s00.is_a? Hash
            hash.case_record(:s00,s00)
        else
            # hash.new_index(:s00)= lambda { a = AxiStream.new(s00);a.name = "s00";return a }
            # hash[:s00] = lambda { a = AxiStream.new(s00);a.name = "s00";return a }
            raise TdlError.new('axi_stream_interconnect_s2m AxiStream s00 TdlHash cant include Proc') if s00.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(s00)
                unless s00[:name]
                    a.name = "s00"
                end
                return a }
            hash.[]=(:s00,lam,false)
        end
                

        unless m00.is_a? Hash
            hash.case_record(:m00,m00)
        else
            # hash.new_index(:m00)= lambda { a = AxiStream.new(m00);a.name = "m00";return a }
            # hash[:m00] = lambda { a = AxiStream.new(m00);a.name = "m00";return a }
            raise TdlError.new('axi_stream_interconnect_s2m AxiStream m00 TdlHash cant include Proc') if m00.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(m00)
                unless m00[:name]
                    a.name = "m00"
                end
                return a }
            hash.[]=(:m00,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:axi_stream_interconnect_s2m)
        hash.open_error = true
        return hash
    end
end
