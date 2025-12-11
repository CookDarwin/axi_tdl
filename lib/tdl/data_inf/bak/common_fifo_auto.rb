
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class DataInf


    def _common_fifo(depth:4,dsize:8,clock:"clock",rst_n:"rst_n",wdata:"wdata",wr_en:"wr_en",rdata:"rdata",rd_en:"rd_en",count:"count",empty:"empty",full:"full")

        Tdl.add_to_all_file_paths(['common_fifo','../../axi/common_fifo/common_fifo.sv'])
        return_stream = self
        

        
        
        

         @instance_draw_stack << lambda { _common_fifo_draw(depth:depth,dsize:dsize,clock:clock,rst_n:rst_n,wdata:wdata,wr_en:wr_en,rdata:rdata,rd_en:rd_en,count:count,empty:empty,full:full) }
        return return_stream
    end

    def _common_fifo_draw(depth:4,dsize:8,clock:"clock",rst_n:"rst_n",wdata:"wdata",wr_en:"wr_en",rdata:"rdata",rd_en:"rd_en",count:"count",empty:"empty",full:"full")

        large_name_len(depth,dsize,clock,rst_n,wdata,wr_en,rdata,rd_en,count,empty,full)
"
// FilePath:::../../axi/common_fifo/common_fifo.sv
common_fifo#(
    .DEPTH    (#{align_signal(depth)}),
    .DSIZE    (#{align_signal(dsize)})
) common_fifo_#{signal}_inst(
/*  input             */ .clock (#{align_signal(clock,q_mark=false)}),
/*  input             */ .rst_n (#{align_signal(rst_n,q_mark=false)}),
/*  input  [DSIZE-1:0]*/ .wdata (#{align_signal(wdata,q_mark=false)}),
/*  input             */ .wr_en (#{align_signal(wr_en,q_mark=false)}),
/*  output [DSIZE-1:0]*/ .rdata (#{align_signal(rdata,q_mark=false)}),
/*  input             */ .rd_en (#{align_signal(rd_en,q_mark=false)}),
/*  output [CSIZE-1:0]*/ .count (#{align_signal(count,q_mark=false)}),
/*  output            */ .empty (#{align_signal(empty,q_mark=false)}),
/*  output            */ .full  (#{align_signal(full,q_mark=false)})
);
"
    end
    
    def self.common_fifo(depth:4,dsize:8,clock:"clock",rst_n:"rst_n",wdata:"wdata",wr_en:"wr_en",rdata:"rdata",rd_en:"rd_en",count:"count",empty:"empty",full:"full")
        return_stream = nil
        
        
        DataInf.NC._common_fifo(depth:depth,dsize:dsize,clock:clock,rst_n:rst_n,wdata:wdata,wr_en:wr_en,rdata:rdata,rd_en:rd_en,count:count,empty:empty,full:full)
        return return_stream
    end
        

end


class TdlTest

    def self.test_common_fifo
        c0 = Clock.new(name:"common_fifo_clk",freqM:148.5)
        r0 = Reset.new(name:"common_fifo_rst_n",active:"low")

        depth = Parameter.new(name:"depth",value:4)
        dsize = Parameter.new(name:"dsize",value:8)
        clock = Logic.new(name:"clock")
        rst_n = Logic.new(name:"rst_n")
        wdata = Logic.new(name:"wdata")
        wr_en = Logic.new(name:"wr_en")
        rdata = Logic.new(name:"rdata")
        rd_en = Logic.new(name:"rd_en")
        count = Logic.new(name:"count")
        empty = Logic.new(name:"empty")
        full = Logic.new(name:"full")
        
        
        DataInf.common_fifo(depth:depth,dsize:dsize,clock:clock,rst_n:rst_n,wdata:wdata,wr_en:wr_en,rdata:rdata,rd_en:rd_en,count:count,empty:empty,full:full)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_common_fifo(
        depth:4,
        dsize:8,
        clock:"clock",
        rst_n:"rst_n",
        wdata:"wdata",
        wr_en:"wr_en",
        rdata:"rdata",
        rd_en:"rd_en",
        count:"count",
        empty:"empty",
        full:"full")
        hash = TdlHash.new
        
        unless depth.is_a? Hash
            hash.case_record(:depth,depth)
        else
            # hash.new_index(:depth)= lambda { a = Parameter.new(depth);a.name = "depth";return a }
            # hash[:depth] = lambda { a = Parameter.new(depth);a.name = "depth";return a }
            raise TdlError.new('common_fifo Parameter depth TdlHash cant include Proc') if depth.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(depth)
                unless depth[:name]
                    a.name = "depth"
                end
                return a }
            hash.[]=(:depth,lam,false)
        end
                

        unless dsize.is_a? Hash
            hash.case_record(:dsize,dsize)
        else
            # hash.new_index(:dsize)= lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            # hash[:dsize] = lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            raise TdlError.new('common_fifo Parameter dsize TdlHash cant include Proc') if dsize.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(dsize)
                unless dsize[:name]
                    a.name = "dsize"
                end
                return a }
            hash.[]=(:dsize,lam,false)
        end
                

        unless clock.is_a? Hash
            hash.case_record(:clock,clock)
        else
            # hash.new_index(:clock)= lambda { a = Logic.new(clock);a.name = "clock";return a }
            # hash[:clock] = lambda { a = Logic.new(clock);a.name = "clock";return a }
            raise TdlError.new('common_fifo Logic clock TdlHash cant include Proc') if clock.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(clock)
                unless clock[:name]
                    a.name = "clock"
                end
                return a }
            hash.[]=(:clock,lam,false)
        end
                

        unless rst_n.is_a? Hash
            hash.case_record(:rst_n,rst_n)
        else
            # hash.new_index(:rst_n)= lambda { a = Logic.new(rst_n);a.name = "rst_n";return a }
            # hash[:rst_n] = lambda { a = Logic.new(rst_n);a.name = "rst_n";return a }
            raise TdlError.new('common_fifo Logic rst_n TdlHash cant include Proc') if rst_n.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(rst_n)
                unless rst_n[:name]
                    a.name = "rst_n"
                end
                return a }
            hash.[]=(:rst_n,lam,false)
        end
                

        unless wdata.is_a? Hash
            hash.case_record(:wdata,wdata)
        else
            # hash.new_index(:wdata)= lambda { a = Logic.new(wdata);a.name = "wdata";return a }
            # hash[:wdata] = lambda { a = Logic.new(wdata);a.name = "wdata";return a }
            raise TdlError.new('common_fifo Logic wdata TdlHash cant include Proc') if wdata.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(wdata)
                unless wdata[:name]
                    a.name = "wdata"
                end
                return a }
            hash.[]=(:wdata,lam,false)
        end
                

        unless wr_en.is_a? Hash
            hash.case_record(:wr_en,wr_en)
        else
            # hash.new_index(:wr_en)= lambda { a = Logic.new(wr_en);a.name = "wr_en";return a }
            # hash[:wr_en] = lambda { a = Logic.new(wr_en);a.name = "wr_en";return a }
            raise TdlError.new('common_fifo Logic wr_en TdlHash cant include Proc') if wr_en.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(wr_en)
                unless wr_en[:name]
                    a.name = "wr_en"
                end
                return a }
            hash.[]=(:wr_en,lam,false)
        end
                

        unless rdata.is_a? Hash
            hash.case_record(:rdata,rdata)
        else
            # hash.new_index(:rdata)= lambda { a = Logic.new(rdata);a.name = "rdata";return a }
            # hash[:rdata] = lambda { a = Logic.new(rdata);a.name = "rdata";return a }
            raise TdlError.new('common_fifo Logic rdata TdlHash cant include Proc') if rdata.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(rdata)
                unless rdata[:name]
                    a.name = "rdata"
                end
                return a }
            hash.[]=(:rdata,lam,false)
        end
                

        unless rd_en.is_a? Hash
            hash.case_record(:rd_en,rd_en)
        else
            # hash.new_index(:rd_en)= lambda { a = Logic.new(rd_en);a.name = "rd_en";return a }
            # hash[:rd_en] = lambda { a = Logic.new(rd_en);a.name = "rd_en";return a }
            raise TdlError.new('common_fifo Logic rd_en TdlHash cant include Proc') if rd_en.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(rd_en)
                unless rd_en[:name]
                    a.name = "rd_en"
                end
                return a }
            hash.[]=(:rd_en,lam,false)
        end
                

        unless count.is_a? Hash
            hash.case_record(:count,count)
        else
            # hash.new_index(:count)= lambda { a = Logic.new(count);a.name = "count";return a }
            # hash[:count] = lambda { a = Logic.new(count);a.name = "count";return a }
            raise TdlError.new('common_fifo Logic count TdlHash cant include Proc') if count.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(count)
                unless count[:name]
                    a.name = "count"
                end
                return a }
            hash.[]=(:count,lam,false)
        end
                

        unless empty.is_a? Hash
            hash.case_record(:empty,empty)
        else
            # hash.new_index(:empty)= lambda { a = Logic.new(empty);a.name = "empty";return a }
            # hash[:empty] = lambda { a = Logic.new(empty);a.name = "empty";return a }
            raise TdlError.new('common_fifo Logic empty TdlHash cant include Proc') if empty.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(empty)
                unless empty[:name]
                    a.name = "empty"
                end
                return a }
            hash.[]=(:empty,lam,false)
        end
                

        unless full.is_a? Hash
            hash.case_record(:full,full)
        else
            # hash.new_index(:full)= lambda { a = Logic.new(full);a.name = "full";return a }
            # hash[:full] = lambda { a = Logic.new(full);a.name = "full";return a }
            raise TdlError.new('common_fifo Logic full TdlHash cant include Proc') if full.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(full)
                unless full[:name]
                    a.name = "full"
                end
                return a }
            hash.[]=(:full,lam,false)
        end
                

        hash.push_to_module_stack(DataInf,:common_fifo)
        hash.open_error = true
        return hash
    end
end
