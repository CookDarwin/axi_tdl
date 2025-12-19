
#2017-12-27 10:16:00 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def _axis_to_axi4_wr(
        addr:"addr",
        max_length:"max_length",
        axis_in:"axis_in",
        axi_wr:"axi_wr"
    )

        Tdl.add_to_all_file_paths(['axis_to_axi4_wr','../../axi/AXI4/axis_to_axi4_wr.sv'])
        return_stream = self
        
        axis_in = AxiStream.same_name_socket(:from_up,mix=true,axis_in) unless axis_in.is_a? String
        axi_wr = Axi4.same_name_socket(:mirror,mix=true,axi_wr) unless axi_wr.is_a? String
        
        
        

         @instance_draw_stack << lambda { _axis_to_axi4_wr_draw(
            addr:addr,
            max_length:max_length,
            axis_in:axis_in,
            axi_wr:axi_wr) }
        return return_stream
    end

    def _axis_to_axi4_wr_draw(
        addr:"addr",
        max_length:"max_length",
        axis_in:"axis_in",
        axi_wr:"axi_wr"
    )

        large_name_len(
            addr,
            max_length,
            axis_in,
            axi_wr
        )
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
    
    def self.axis_to_axi4_wr(
        addr:"addr",
        max_length:"max_length",
        axis_in:"axis_in",
        axi_wr:"axi_wr"
    )
        return_stream = nil
        
        
        AxiStream.NC._axis_to_axi4_wr(
            addr:addr,
                max_length:max_length,
                axis_in:axis_in,
                axi_wr:axi_wr)
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
        
        
        AxiStream.axis_to_axi4_wr(
            addr:addr,
            max_length:max_length,
            axis_in:axis_in,
            axi_wr:axi_wr)

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
            hash.case_record(:addr,addr)
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
            hash.case_record(:max_length,max_length)
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
            hash.case_record(:axis_in,axis_in)
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
            hash.case_record(:axi_wr,axi_wr)
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
                

        hash.push_to_module_stack(AxiStream,:axis_to_axi4_wr)
        hash.open_error = true
        return hash
    end
end
