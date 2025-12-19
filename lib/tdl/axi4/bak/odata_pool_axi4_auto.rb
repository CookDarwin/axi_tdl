
#2017-12-27 10:16:00 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class Axi4


    def _odata_pool_axi4(
        dsize:8,
        rd_clk:"rd_clk",
        rd_rst_n:"rd_rst_n",
        data:"data",
        empty:"empty",
        rd_en:"rd_en",
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        last_drop:"last_drop",
        axi_master:"axi_master"
    )

        Tdl.add_to_all_file_paths(['odata_pool_axi4','../../axi/AXI4/odata_pool_axi4.sv'])
        return_stream = self
        
        axi_master = Axi4.same_name_socket(:mirror,mix=true,axi_master) unless axi_master.is_a? String
        
        
        

         @instance_draw_stack << lambda { _odata_pool_axi4_draw(
            dsize:dsize,
            rd_clk:rd_clk,
            rd_rst_n:rd_rst_n,
            data:data,
            empty:empty,
            rd_en:rd_en,
            source_addr:source_addr,
            size:size,
            valid:valid,
            ready:ready,
            last_drop:last_drop,
            axi_master:axi_master) }
        return return_stream
    end

    def _odata_pool_axi4_draw(
        dsize:8,
        rd_clk:"rd_clk",
        rd_rst_n:"rd_rst_n",
        data:"data",
        empty:"empty",
        rd_en:"rd_en",
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        last_drop:"last_drop",
        axi_master:"axi_master"
    )

        large_name_len(
            dsize,
            rd_clk,
            rd_rst_n,
            data,
            empty,
            rd_en,
            source_addr,
            size,
            valid,
            ready,
            last_drop,
            axi_master
        )
"
// FilePath:::../../axi/AXI4/odata_pool_axi4.sv
odata_pool_axi4#(
    .DSIZE    (#{align_signal(dsize)})
) odata_pool_axi4_#{signal}_inst(
/*  input             */ .rd_clk      (#{align_signal(rd_clk,q_mark=false)}),
/*  input             */ .rd_rst_n    (#{align_signal(rd_rst_n,q_mark=false)}),
/*  output [DSIZE-1:0]*/ .data        (#{align_signal(data,q_mark=false)}),
/*  output            */ .empty       (#{align_signal(empty,q_mark=false)}),
/*  input             */ .rd_en       (#{align_signal(rd_en,q_mark=false)}),
/*  input  [31:0]     */ .source_addr (#{align_signal(source_addr,q_mark=false)}),
/*  input  [31:0]     */ .size        (#{align_signal(size,q_mark=false)}),
/*  input             */ .valid       (#{align_signal(valid,q_mark=false)}),
/*  output            */ .ready       (#{align_signal(ready,q_mark=false)}),
/*  output            */ .last_drop   (#{align_signal(last_drop,q_mark=false)}),
/*  axi_inf.master_rd */ .axi_master  (#{align_signal(axi_master,q_mark=false)})
);
"
    end
    
    def self.odata_pool_axi4(
        dsize:8,
        rd_clk:"rd_clk",
        rd_rst_n:"rd_rst_n",
        data:"data",
        empty:"empty",
        rd_en:"rd_en",
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        last_drop:"last_drop",
        axi_master:"axi_master"
    )
        return_stream = nil
        
        
        Axi4.NC._odata_pool_axi4(
            dsize:dsize,
                rd_clk:rd_clk,
                rd_rst_n:rd_rst_n,
                data:data,
                empty:empty,
                rd_en:rd_en,
                source_addr:source_addr,
                size:size,
                valid:valid,
                ready:ready,
                last_drop:last_drop,
                axi_master:axi_master)
        return return_stream
    end
        

end


class TdlTest

    def self.test_odata_pool_axi4
        c0 = Clock.new(name:"odata_pool_axi4_clk",freqM:148.5)
        r0 = Reset.new(name:"odata_pool_axi4_rst_n",active:"low")

        dsize = Parameter.new(name:"dsize",value:8)
        rd_clk = Logic.new(name:"rd_clk")
        rd_rst_n = Logic.new(name:"rd_rst_n")
        data = Logic.new(name:"data")
        empty = Logic.new(name:"empty")
        rd_en = Logic.new(name:"rd_en")
        source_addr = Logic.new(name:"source_addr")
        size = Logic.new(name:"size")
        valid = Logic.new(name:"valid")
        ready = Logic.new(name:"ready")
        last_drop = Logic.new(name:"last_drop")
        axi_master = Axi4.new(name:"axi_master",clock:c0,reset:r0)
        
        
        Axi4.odata_pool_axi4(
            dsize:dsize,
            rd_clk:rd_clk,
            rd_rst_n:rd_rst_n,
            data:data,
            empty:empty,
            rd_en:rd_en,
            source_addr:source_addr,
            size:size,
            valid:valid,
            ready:ready,
            last_drop:last_drop,
            axi_master:axi_master)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_odata_pool_axi4(
        dsize:8,
        rd_clk:"rd_clk",
        rd_rst_n:"rd_rst_n",
        data:"data",
        empty:"empty",
        rd_en:"rd_en",
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        last_drop:"last_drop",
        axi_master:"axi_master")
        hash = TdlHash.new
        
        unless dsize.is_a? Hash
            hash.case_record(:dsize,dsize)
        else
            # hash.new_index(:dsize)= lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            # hash[:dsize] = lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            raise TdlError.new('odata_pool_axi4 Parameter dsize TdlHash cant include Proc') if dsize.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(dsize)
                unless dsize[:name]
                    a.name = "dsize"
                end
                return a }
            hash.[]=(:dsize,lam,false)
        end
                

        unless rd_clk.is_a? Hash
            hash.case_record(:rd_clk,rd_clk)
        else
            # hash.new_index(:rd_clk)= lambda { a = Logic.new(rd_clk);a.name = "rd_clk";return a }
            # hash[:rd_clk] = lambda { a = Logic.new(rd_clk);a.name = "rd_clk";return a }
            raise TdlError.new('odata_pool_axi4 Logic rd_clk TdlHash cant include Proc') if rd_clk.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(rd_clk)
                unless rd_clk[:name]
                    a.name = "rd_clk"
                end
                return a }
            hash.[]=(:rd_clk,lam,false)
        end
                

        unless rd_rst_n.is_a? Hash
            hash.case_record(:rd_rst_n,rd_rst_n)
        else
            # hash.new_index(:rd_rst_n)= lambda { a = Logic.new(rd_rst_n);a.name = "rd_rst_n";return a }
            # hash[:rd_rst_n] = lambda { a = Logic.new(rd_rst_n);a.name = "rd_rst_n";return a }
            raise TdlError.new('odata_pool_axi4 Logic rd_rst_n TdlHash cant include Proc') if rd_rst_n.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(rd_rst_n)
                unless rd_rst_n[:name]
                    a.name = "rd_rst_n"
                end
                return a }
            hash.[]=(:rd_rst_n,lam,false)
        end
                

        unless data.is_a? Hash
            hash.case_record(:data,data)
        else
            # hash.new_index(:data)= lambda { a = Logic.new(data);a.name = "data";return a }
            # hash[:data] = lambda { a = Logic.new(data);a.name = "data";return a }
            raise TdlError.new('odata_pool_axi4 Logic data TdlHash cant include Proc') if data.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(data)
                unless data[:name]
                    a.name = "data"
                end
                return a }
            hash.[]=(:data,lam,false)
        end
                

        unless empty.is_a? Hash
            hash.case_record(:empty,empty)
        else
            # hash.new_index(:empty)= lambda { a = Logic.new(empty);a.name = "empty";return a }
            # hash[:empty] = lambda { a = Logic.new(empty);a.name = "empty";return a }
            raise TdlError.new('odata_pool_axi4 Logic empty TdlHash cant include Proc') if empty.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(empty)
                unless empty[:name]
                    a.name = "empty"
                end
                return a }
            hash.[]=(:empty,lam,false)
        end
                

        unless rd_en.is_a? Hash
            hash.case_record(:rd_en,rd_en)
        else
            # hash.new_index(:rd_en)= lambda { a = Logic.new(rd_en);a.name = "rd_en";return a }
            # hash[:rd_en] = lambda { a = Logic.new(rd_en);a.name = "rd_en";return a }
            raise TdlError.new('odata_pool_axi4 Logic rd_en TdlHash cant include Proc') if rd_en.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(rd_en)
                unless rd_en[:name]
                    a.name = "rd_en"
                end
                return a }
            hash.[]=(:rd_en,lam,false)
        end
                

        unless source_addr.is_a? Hash
            hash.case_record(:source_addr,source_addr)
        else
            # hash.new_index(:source_addr)= lambda { a = Logic.new(source_addr);a.name = "source_addr";return a }
            # hash[:source_addr] = lambda { a = Logic.new(source_addr);a.name = "source_addr";return a }
            raise TdlError.new('odata_pool_axi4 Logic source_addr TdlHash cant include Proc') if source_addr.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(source_addr)
                unless source_addr[:name]
                    a.name = "source_addr"
                end
                return a }
            hash.[]=(:source_addr,lam,false)
        end
                

        unless size.is_a? Hash
            hash.case_record(:size,size)
        else
            # hash.new_index(:size)= lambda { a = Logic.new(size);a.name = "size";return a }
            # hash[:size] = lambda { a = Logic.new(size);a.name = "size";return a }
            raise TdlError.new('odata_pool_axi4 Logic size TdlHash cant include Proc') if size.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(size)
                unless size[:name]
                    a.name = "size"
                end
                return a }
            hash.[]=(:size,lam,false)
        end
                

        unless valid.is_a? Hash
            hash.case_record(:valid,valid)
        else
            # hash.new_index(:valid)= lambda { a = Logic.new(valid);a.name = "valid";return a }
            # hash[:valid] = lambda { a = Logic.new(valid);a.name = "valid";return a }
            raise TdlError.new('odata_pool_axi4 Logic valid TdlHash cant include Proc') if valid.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(valid)
                unless valid[:name]
                    a.name = "valid"
                end
                return a }
            hash.[]=(:valid,lam,false)
        end
                

        unless ready.is_a? Hash
            hash.case_record(:ready,ready)
        else
            # hash.new_index(:ready)= lambda { a = Logic.new(ready);a.name = "ready";return a }
            # hash[:ready] = lambda { a = Logic.new(ready);a.name = "ready";return a }
            raise TdlError.new('odata_pool_axi4 Logic ready TdlHash cant include Proc') if ready.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(ready)
                unless ready[:name]
                    a.name = "ready"
                end
                return a }
            hash.[]=(:ready,lam,false)
        end
                

        unless last_drop.is_a? Hash
            hash.case_record(:last_drop,last_drop)
        else
            # hash.new_index(:last_drop)= lambda { a = Logic.new(last_drop);a.name = "last_drop";return a }
            # hash[:last_drop] = lambda { a = Logic.new(last_drop);a.name = "last_drop";return a }
            raise TdlError.new('odata_pool_axi4 Logic last_drop TdlHash cant include Proc') if last_drop.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(last_drop)
                unless last_drop[:name]
                    a.name = "last_drop"
                end
                return a }
            hash.[]=(:last_drop,lam,false)
        end
                

        unless axi_master.is_a? Hash
            hash.case_record(:axi_master,axi_master)
        else
            # hash.new_index(:axi_master)= lambda { a = Axi4.new(axi_master);a.name = "axi_master";return a }
            # hash[:axi_master] = lambda { a = Axi4.new(axi_master);a.name = "axi_master";return a }
            raise TdlError.new('odata_pool_axi4 Axi4 axi_master TdlHash cant include Proc') if axi_master.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Axi4.new(axi_master)
                unless axi_master[:name]
                    a.name = "axi_master"
                end
                return a }
            hash.[]=(:axi_master,lam,false)
        end
                

        hash.push_to_module_stack(Axi4,:odata_pool_axi4)
        hash.open_error = true
        return hash
    end
end
