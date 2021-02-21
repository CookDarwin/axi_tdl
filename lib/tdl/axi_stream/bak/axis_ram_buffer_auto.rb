
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_ram_buffer(length:4096,wr_en:"wr_en",gen_en:"gen_en",gen_ready:"gen_ready",axis_wr_inf:"axis_wr_inf",axis_data_inf:"axis_data_inf",up_stream:nil,down_stream:nil)

        Tdl.add_to_all_file_paths(['axis_ram_buffer','../../axi/AXI_stream/axis_ram_buffer.sv'])
        return_stream = self
        
        axis_wr_inf = AxiStream.same_name_socket(:from_up,mix=true,axis_wr_inf) unless axis_wr_inf.is_a? String
        axis_data_inf = AxiStream.same_name_socket(:to_down,mix=true,axis_data_inf) unless axis_data_inf.is_a? String
        
        if up_stream==nil && axis_wr_inf=="axis_wr_inf"
            up_stream = self.copy(name:"axis_wr_inf")
            return_stream = up_stream
        end

        axis_wr_inf = up_stream if up_stream
        axis_data_inf = self unless self==AxiStream.NC

         @instance_draw_stack << lambda { axis_ram_buffer_draw(length:length,wr_en:wr_en,gen_en:gen_en,gen_ready:gen_ready,axis_wr_inf:axis_wr_inf,axis_data_inf:axis_data_inf,up_stream:up_stream,down_stream:down_stream) }
        return return_stream
    end

    def axis_ram_buffer_draw(length:4096,wr_en:"wr_en",gen_en:"gen_en",gen_ready:"gen_ready",axis_wr_inf:"axis_wr_inf",axis_data_inf:"axis_data_inf",up_stream:nil,down_stream:nil)

        large_name_len(length,wr_en,gen_en,gen_ready,axis_wr_inf,axis_data_inf)
"
// FilePath:::../../axi/AXI_stream/axis_ram_buffer.sv
axis_ram_buffer#(
    .LENGTH    (#{align_signal(length)})
) axis_ram_buffer_#{signal}_inst(
/*  input                */ .wr_en         (#{align_signal(wr_en,q_mark=false)}),
/*  input                */ .gen_en        (#{align_signal(gen_en,q_mark=false)}),
/*  output               */ .gen_ready     (#{align_signal(gen_ready,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .axis_wr_inf   (#{align_signal(axis_wr_inf,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_data_inf (#{align_signal(axis_data_inf,q_mark=false)})
);
"
    end
    
    def self.axis_ram_buffer(length:4096,wr_en:"wr_en",gen_en:"gen_en",gen_ready:"gen_ready",axis_wr_inf:"axis_wr_inf",axis_data_inf:"axis_data_inf",up_stream:nil,down_stream:nil)
        return_stream = nil
        
        if down_stream==nil && axis_data_inf=="axis_data_inf"
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy(name:"axis_data_inf")
            else
                down_stream = axis_wr_inf.copy(name:"axis_data_inf")
            end
            return_stream = down_stream
        end

        
        if up_stream==nil && axis_wr_inf=="axis_wr_inf"
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy(name:"axis_wr_inf")
            else
                up_stream = axis_data_inf.copy(name:"axis_wr_inf")
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axis_ram_buffer(length:length,wr_en:wr_en,gen_en:gen_en,gen_ready:gen_ready,axis_wr_inf:axis_wr_inf,axis_data_inf:axis_data_inf,up_stream:up_stream,down_stream:down_stream)
        elsif axis_data_inf.is_a? AxiStream
            axis_data_inf.axis_ram_buffer(length:length,wr_en:wr_en,gen_en:gen_en,gen_ready:gen_ready,axis_wr_inf:axis_wr_inf,axis_data_inf:axis_data_inf,up_stream:up_stream,down_stream:down_stream)
        else
            AxiStream.NC.axis_ram_buffer(length:length,wr_en:wr_en,gen_en:gen_en,gen_ready:gen_ready,axis_wr_inf:axis_wr_inf,axis_data_inf:axis_data_inf,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_axis_ram_buffer
        c0 = Clock.new(name:"axis_ram_buffer_clk",freqM:148.5)
        r0 = Reset.new(name:"axis_ram_buffer_rst_n",active:"low")

        length = Parameter.new(name:"length",value:4096)
        wr_en = Logic.new(name:"wr_en")
        gen_en = Logic.new(name:"gen_en")
        gen_ready = Logic.new(name:"gen_ready")
        axis_wr_inf = AxiStream.new(name:"axis_wr_inf",clock:c0,reset:r0)
        axis_data_inf = AxiStream.new(name:"axis_data_inf",clock:c0,reset:r0)
        up_stream = axis_wr_inf
        down_stream = axis_data_inf
        AxiStream.axis_ram_buffer(length:length,wr_en:wr_en,gen_en:gen_en,gen_ready:gen_ready,axis_wr_inf:axis_wr_inf,axis_data_inf:axis_data_inf)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axis_ram_buffer(
        length:4096,
        wr_en:"wr_en",
        gen_en:"gen_en",
        gen_ready:"gen_ready",
        axis_wr_inf:"axis_wr_inf",
        axis_data_inf:"axis_data_inf")
        hash = TdlHash.new
        
        unless length.is_a? Hash
            hash.case_record(:length,length)
        else
            # hash.new_index(:length)= lambda { a = Parameter.new(length);a.name = "length";return a }
            # hash[:length] = lambda { a = Parameter.new(length);a.name = "length";return a }
            raise TdlError.new('axis_ram_buffer Parameter length TdlHash cant include Proc') if length.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(length)
                unless length[:name]
                    a.name = "length"
                end
                return a }
            hash.[]=(:length,lam,false)
        end
                

        unless wr_en.is_a? Hash
            hash.case_record(:wr_en,wr_en)
        else
            # hash.new_index(:wr_en)= lambda { a = Logic.new(wr_en);a.name = "wr_en";return a }
            # hash[:wr_en] = lambda { a = Logic.new(wr_en);a.name = "wr_en";return a }
            raise TdlError.new('axis_ram_buffer Logic wr_en TdlHash cant include Proc') if wr_en.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(wr_en)
                unless wr_en[:name]
                    a.name = "wr_en"
                end
                return a }
            hash.[]=(:wr_en,lam,false)
        end
                

        unless gen_en.is_a? Hash
            hash.case_record(:gen_en,gen_en)
        else
            # hash.new_index(:gen_en)= lambda { a = Logic.new(gen_en);a.name = "gen_en";return a }
            # hash[:gen_en] = lambda { a = Logic.new(gen_en);a.name = "gen_en";return a }
            raise TdlError.new('axis_ram_buffer Logic gen_en TdlHash cant include Proc') if gen_en.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(gen_en)
                unless gen_en[:name]
                    a.name = "gen_en"
                end
                return a }
            hash.[]=(:gen_en,lam,false)
        end
                

        unless gen_ready.is_a? Hash
            hash.case_record(:gen_ready,gen_ready)
        else
            # hash.new_index(:gen_ready)= lambda { a = Logic.new(gen_ready);a.name = "gen_ready";return a }
            # hash[:gen_ready] = lambda { a = Logic.new(gen_ready);a.name = "gen_ready";return a }
            raise TdlError.new('axis_ram_buffer Logic gen_ready TdlHash cant include Proc') if gen_ready.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(gen_ready)
                unless gen_ready[:name]
                    a.name = "gen_ready"
                end
                return a }
            hash.[]=(:gen_ready,lam,false)
        end
                

        unless axis_wr_inf.is_a? Hash
            hash.case_record(:axis_wr_inf,axis_wr_inf)
        else
            # hash.new_index(:axis_wr_inf)= lambda { a = AxiStream.new(axis_wr_inf);a.name = "axis_wr_inf";return a }
            # hash[:axis_wr_inf] = lambda { a = AxiStream.new(axis_wr_inf);a.name = "axis_wr_inf";return a }
            raise TdlError.new('axis_ram_buffer AxiStream axis_wr_inf TdlHash cant include Proc') if axis_wr_inf.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_wr_inf)
                unless axis_wr_inf[:name]
                    a.name = "axis_wr_inf"
                end
                return a }
            hash.[]=(:axis_wr_inf,lam,false)
        end
                

        unless axis_data_inf.is_a? Hash
            hash.case_record(:axis_data_inf,axis_data_inf)
        else
            # hash.new_index(:axis_data_inf)= lambda { a = AxiStream.new(axis_data_inf);a.name = "axis_data_inf";return a }
            # hash[:axis_data_inf] = lambda { a = AxiStream.new(axis_data_inf);a.name = "axis_data_inf";return a }
            raise TdlError.new('axis_ram_buffer AxiStream axis_data_inf TdlHash cant include Proc') if axis_data_inf.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_data_inf)
                unless axis_data_inf[:name]
                    a.name = "axis_data_inf"
                end
                return a }
            hash.[]=(:axis_data_inf,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:axis_ram_buffer)
        hash.open_error = true
        return hash
    end
end
