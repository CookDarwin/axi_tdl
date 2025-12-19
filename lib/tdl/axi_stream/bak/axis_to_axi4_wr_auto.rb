
#2017-10-11 10:12:24 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def _axis_to_axi4_wr(addr:"addr",max_length:"max_length",axis_in:"axis_in",axi_wr:"axi_wr")
        Tdl.add_to_all_file_paths(['axis_length_split_with_addr','../../axi/AXI_stream/axis_length_split_with_addr.sv'])
        Tdl.add_to_all_file_paths(['axis_valve_with_pipe','../../axi/AXI_stream/axis_valve_with_pipe.sv'])
        Tdl.add_to_all_file_paths(['axi_stream_long_fifo','../../axi/AXI_stream/packet_fifo/axi_stream_long_fifo.sv'])
        Tdl.add_to_all_file_paths(['independent_clock_fifo','../../axi/common_fifo/independent_clock_fifo.sv'])
        Tdl.add_to_all_file_paths(['axi4_wr_auxiliary_gen_without_resp','../../axi/AXI4/axi4_wr_auxiliary_gen_without_resp.sv'])
        Tdl.add_to_all_file_paths(['axis_to_axi4_wr','../../axi/AXI4/axis_to_axi4_wr.sv'])
        return_stream = self
        
        axis_in = AxiStream.same_name_socket(:from_up,mix=true,axis_in) unless axis_in.is_a? String
        axi_wr = Axi4.same_name_socket(:mirror,mix=true,axi_wr) unless axi_wr.is_a? String
        
        
        

         @instance_draw_stack << lambda { _axis_to_axi4_wr_draw(addr:addr,max_length:max_length,axis_in:axis_in,axi_wr:axi_wr) }
        return return_stream
    end

    def _axis_to_axi4_wr_draw(addr:"addr",max_length:"max_length",axis_in:"axis_in",axi_wr:"axi_wr")

        large_name_len(addr,max_length,axis_in,axi_wr)
"
// FilePath:::../../axi/AXI4/axis_to_axi4_wr.sv
axis_to_axi4_wr axis_to_axi4_wr_#{signal}_inst(
/*  input  [31:0]        */ .addr       (#{align_signal(addr,q_mark=false)}),
/*  input  [31:0]        */ .max_length (#{align_signal(max_length,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .axis_in    (#{align_signal(axis_in,q_mark=false)}),
/*  axi_inf.master_wr    */ .axi_wr     (#{align_signal(axi_wr,q_mark=false)})
);
"
    end
    
    def self.axis_to_axi4_wr(addr:"addr",max_length:"max_length",axis_in:"axis_in",axi_wr:"axi_wr")
        return_stream = nil
        
        
        NC._axis_to_axi4_wr(addr:addr,max_length:max_length,axis_in:axis_in,axi_wr:axi_wr)
        return return_stream
    end
        

end


class TdlTest

    def self.test_axis_to_axi4_wr
        c0 = Clock.new(name:"axis_to_axi4_wr_clk",freqM:148.5)
        r0 = Reset.new(name:"axis_to_axi4_wr_rst_n",active:"low")

        addr = Logic.new(name:"addr")
        max_length = Logic.new(name:"max_length")
        axis_in = AxiStream.new(name:"axis_in",clock:c0,reset:r0)
        axi_wr = Axi4.new(name:"axi_wr",clock:c0,reset:r0)
        
        
        AxiStream.axis_to_axi4_wr(addr:addr,max_length:max_length,axis_in:axis_in,axi_wr:axi_wr)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axis_to_axi4_wr(
        addr:"addr",
        max_length:"max_length",
        axis_in:"axis_in",
        axi_wr:"axi_wr")
        hash = TdlHash.new
        
        unless addr.is_a? Hash
            # hash.new_index(:addr) = addr
            if addr.is_a? BaseElm
                hash.[]=(:addr,addr,true);hash[:addr];
                # hash.[]=(:addr,addr,false)
            elsif addr.is_a? GlobalSignalProc
                hash.[]=(:addr,addr,true)
            else
                hash.[]=(:addr,addr,false)
            end
        else
            # hash.new_index(:addr)= lambda { a = Logic.new(addr);a.name = "addr";return a }
            # hash[:addr] = lambda { a = Logic.new(addr);a.name = "addr";return a }
            raise TdlError.new('axis_to_axi4_wr Logic addr TdlHash cant include Proc') if addr.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(addr)
                unless addr[:name]
                    a.name = "addr"
                end
                return a }
            hash.[]=(:addr,lam,false)
        end
                

        unless max_length.is_a? Hash
            # hash.new_index(:max_length) = max_length
            if max_length.is_a? BaseElm
                hash.[]=(:max_length,max_length,true);hash[:max_length];
                # hash.[]=(:max_length,max_length,false)
            elsif max_length.is_a? GlobalSignalProc
                hash.[]=(:max_length,max_length,true)
            else
                hash.[]=(:max_length,max_length,false)
            end
        else
            # hash.new_index(:max_length)= lambda { a = Logic.new(max_length);a.name = "max_length";return a }
            # hash[:max_length] = lambda { a = Logic.new(max_length);a.name = "max_length";return a }
            raise TdlError.new('axis_to_axi4_wr Logic max_length TdlHash cant include Proc') if max_length.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(max_length)
                unless max_length[:name]
                    a.name = "max_length"
                end
                return a }
            hash.[]=(:max_length,lam,false)
        end
                

        unless axis_in.is_a? Hash
            # hash.new_index(:axis_in) = axis_in
            if axis_in.is_a? BaseElm
                hash.[]=(:axis_in,axis_in,true);hash[:axis_in];
                # hash.[]=(:axis_in,axis_in,false)
            elsif axis_in.is_a? GlobalSignalProc
                hash.[]=(:axis_in,axis_in,true)
            else
                hash.[]=(:axis_in,axis_in,false)
            end
        else
            # hash.new_index(:axis_in)= lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            # hash[:axis_in] = lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            raise TdlError.new('axis_to_axi4_wr AxiStream axis_in TdlHash cant include Proc') if axis_in.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_in)
                unless axis_in[:name]
                    a.name = "axis_in"
                end
                return a }
            hash.[]=(:axis_in,lam,false)
        end
                

        unless axi_wr.is_a? Hash
            # hash.new_index(:axi_wr) = axi_wr
            if axi_wr.is_a? BaseElm
                hash.[]=(:axi_wr,axi_wr,true);hash[:axi_wr];
                # hash.[]=(:axi_wr,axi_wr,false)
            elsif axi_wr.is_a? GlobalSignalProc
                hash.[]=(:axi_wr,axi_wr,true)
            else
                hash.[]=(:axi_wr,axi_wr,false)
            end
        else
            # hash.new_index(:axi_wr)= lambda { a = Axi4.new(axi_wr);a.name = "axi_wr";return a }
            # hash[:axi_wr] = lambda { a = Axi4.new(axi_wr);a.name = "axi_wr";return a }
            raise TdlError.new('axis_to_axi4_wr Axi4 axi_wr TdlHash cant include Proc') if axi_wr.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Axi4.new(axi_wr)
                unless axi_wr[:name]
                    a.name = "axi_wr"
                end
                return a }
            hash.[]=(:axi_wr,lam,false)
        end
                

        Tdl.module_stack  << lambda {
            hash.each do |k,v|
                if v.is_a? Proc
                    hash.[]=(k,v.call,false)
                elsif v.is_a? Array
                #    unless v.empty?
                #        if v[0].is_a? Axi4
                #            cm = v[0].copy(name:k,idsize:Math.log2(v.length).ceil+v[0].idsize)
                #        else
                #            cm = v[0].copy(name:k)
                #        end
                #        cm.<<(*v)
                #        # hash[k] = cm
                #        hash.[]=(k,cm)
                #    else
                #        hash.[]=(k,nil,false)
                #    end
                else
                    # hash[k] = v
                end
            end
            hash.check_use("axis_to_axi4_wr")
            AxiStream.axis_to_axi4_wr(hash)
        }
        hash.open_error = true
        return hash
    end
end
