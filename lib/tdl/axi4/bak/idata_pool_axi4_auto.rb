
#2017-12-27 10:16:00 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class Axi4


    def idata_pool_axi4(
        dsize:8,
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        last_drop:"last_drop",
        data:"data",
        empty:"empty",
        wr_en:"wr_en",
        sewage_valve:"sewage_valve",
        axi_master:"axi_master",
        down_stream:nil
    )

        Tdl.add_to_all_file_paths(['idata_pool_axi4','../../axi/AXI4/idata_pool_axi4.sv'])
        return_stream = self
        
        axi_master = Axi4.same_name_socket(:mirror,mix=true,axi_master) unless axi_master.is_a? String
        
        
        axi_master = self unless self==Axi4.NC

         @instance_draw_stack << lambda { idata_pool_axi4_draw(
            dsize:dsize,
            source_addr:source_addr,
            size:size,
            valid:valid,
            ready:ready,
            last_drop:last_drop,
            data:data,
            empty:empty,
            wr_en:wr_en,
            sewage_valve:sewage_valve,
            axi_master:axi_master,
            down_stream:down_stream) }
        return return_stream
    end

    def idata_pool_axi4_draw(
        dsize:8,
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        last_drop:"last_drop",
        data:"data",
        empty:"empty",
        wr_en:"wr_en",
        sewage_valve:"sewage_valve",
        axi_master:"axi_master",
        down_stream:nil
    )

        large_name_len(
            dsize,
            source_addr,
            size,
            valid,
            ready,
            last_drop,
            data,
            empty,
            wr_en,
            sewage_valve,
            axi_master
        )
"
// FilePath:::../../axi/AXI4/idata_pool_axi4.sv
idata_pool_axi4#(
    .DSIZE    (#{align_signal(dsize)})
) idata_pool_axi4_#{signal}_inst(
/*  input  [31:0]     */ .source_addr  (#{align_signal(source_addr,q_mark=false)}),
/*  input  [31:0]     */ .size         (#{align_signal(size,q_mark=false)}),
/*  input             */ .valid        (#{align_signal(valid,q_mark=false)}),
/*  output            */ .ready        (#{align_signal(ready,q_mark=false)}),
/*  output            */ .last_drop    (#{align_signal(last_drop,q_mark=false)}),
/*  input  [DSIZE-1:0]*/ .data         (#{align_signal(data,q_mark=false)}),
/*  output            */ .empty        (#{align_signal(empty,q_mark=false)}),
/*  input             */ .wr_en        (#{align_signal(wr_en,q_mark=false)}),
/*  input             */ .sewage_valve (#{align_signal(sewage_valve,q_mark=false)}),
/*  axi_inf.master_wr */ .axi_master   (#{align_signal(axi_master,q_mark=false)})
);
"
    end
    
    def self.idata_pool_axi4(
        dsize:8,
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        last_drop:"last_drop",
        data:"data",
        empty:"empty",
        wr_en:"wr_en",
        sewage_valve:"sewage_valve",
        axi_master:"axi_master",
        down_stream:nil
    )
        return_stream = nil
        
        
        
        if down_stream.is_a? Axi4
            down_stream.idata_pool_axi4(
                dsize:dsize,
                source_addr:source_addr,
                size:size,
                valid:valid,
                ready:ready,
                last_drop:last_drop,
                data:data,
                empty:empty,
                wr_en:wr_en,
                sewage_valve:sewage_valve,
                axi_master:axi_master,
                down_stream:down_stream)
        elsif axi_master.is_a? Axi4
            axi_master.idata_pool_axi4(
                dsize:dsize,
                source_addr:source_addr,
                size:size,
                valid:valid,
                ready:ready,
                last_drop:last_drop,
                data:data,
                empty:empty,
                wr_en:wr_en,
                sewage_valve:sewage_valve,
                axi_master:axi_master,
                down_stream:down_stream)
        else
            Axi4.NC.idata_pool_axi4(
                dsize:dsize,
                source_addr:source_addr,
                size:size,
                valid:valid,
                ready:ready,
                last_drop:last_drop,
                data:data,
                empty:empty,
                wr_en:wr_en,
                sewage_valve:sewage_valve,
                axi_master:axi_master,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_idata_pool_axi4
        c0 = Clock.new(name:"idata_pool_axi4_clk",freqM:148.5)
        r0 = Reset.new(name:"idata_pool_axi4_rst_n",active:"low")

        dsize = Parameter.new(name:"dsize",value:8)
        source_addr = Logic.new(name:"source_addr")
        size = Logic.new(name:"size")
        valid = Logic.new(name:"valid")
        ready = Logic.new(name:"ready")
        last_drop = Logic.new(name:"last_drop")
        data = Logic.new(name:"data")
        empty = Logic.new(name:"empty")
        wr_en = Logic.new(name:"wr_en")
        sewage_valve = Logic.new(name:"sewage_valve")
        axi_master = Axi4.new(name:"axi_master",clock:c0,reset:r0)
        
        down_stream = axi_master
        Axi4.idata_pool_axi4(
            dsize:dsize,
            source_addr:source_addr,
            size:size,
            valid:valid,
            ready:ready,
            last_drop:last_drop,
            data:data,
            empty:empty,
            wr_en:wr_en,
            sewage_valve:sewage_valve,
            axi_master:axi_master)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_idata_pool_axi4(
        dsize:8,
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        last_drop:"last_drop",
        data:"data",
        empty:"empty",
        wr_en:"wr_en",
        sewage_valve:"sewage_valve",
        axi_master:"axi_master")
        hash = TdlHash.new
        
        unless dsize.is_a? Hash
            hash.case_record(:dsize,dsize)
        else
            # hash.new_index(:dsize)= lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            # hash[:dsize] = lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            raise TdlError.new('idata_pool_axi4 Parameter dsize TdlHash cant include Proc') if dsize.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(dsize)
                unless dsize[:name]
                    a.name = "dsize"
                end
                return a }
            hash.[]=(:dsize,lam,false)
        end
                

        unless source_addr.is_a? Hash
            hash.case_record(:source_addr,source_addr)
        else
            # hash.new_index(:source_addr)= lambda { a = Logic.new(source_addr);a.name = "source_addr";return a }
            # hash[:source_addr] = lambda { a = Logic.new(source_addr);a.name = "source_addr";return a }
            raise TdlError.new('idata_pool_axi4 Logic source_addr TdlHash cant include Proc') if source_addr.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('idata_pool_axi4 Logic size TdlHash cant include Proc') if size.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('idata_pool_axi4 Logic valid TdlHash cant include Proc') if valid.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('idata_pool_axi4 Logic ready TdlHash cant include Proc') if ready.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('idata_pool_axi4 Logic last_drop TdlHash cant include Proc') if last_drop.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(last_drop)
                unless last_drop[:name]
                    a.name = "last_drop"
                end
                return a }
            hash.[]=(:last_drop,lam,false)
        end
                

        unless data.is_a? Hash
            hash.case_record(:data,data)
        else
            # hash.new_index(:data)= lambda { a = Logic.new(data);a.name = "data";return a }
            # hash[:data] = lambda { a = Logic.new(data);a.name = "data";return a }
            raise TdlError.new('idata_pool_axi4 Logic data TdlHash cant include Proc') if data.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('idata_pool_axi4 Logic empty TdlHash cant include Proc') if empty.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(empty)
                unless empty[:name]
                    a.name = "empty"
                end
                return a }
            hash.[]=(:empty,lam,false)
        end
                

        unless wr_en.is_a? Hash
            hash.case_record(:wr_en,wr_en)
        else
            # hash.new_index(:wr_en)= lambda { a = Logic.new(wr_en);a.name = "wr_en";return a }
            # hash[:wr_en] = lambda { a = Logic.new(wr_en);a.name = "wr_en";return a }
            raise TdlError.new('idata_pool_axi4 Logic wr_en TdlHash cant include Proc') if wr_en.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(wr_en)
                unless wr_en[:name]
                    a.name = "wr_en"
                end
                return a }
            hash.[]=(:wr_en,lam,false)
        end
                

        unless sewage_valve.is_a? Hash
            hash.case_record(:sewage_valve,sewage_valve)
        else
            # hash.new_index(:sewage_valve)= lambda { a = Logic.new(sewage_valve);a.name = "sewage_valve";return a }
            # hash[:sewage_valve] = lambda { a = Logic.new(sewage_valve);a.name = "sewage_valve";return a }
            raise TdlError.new('idata_pool_axi4 Logic sewage_valve TdlHash cant include Proc') if sewage_valve.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(sewage_valve)
                unless sewage_valve[:name]
                    a.name = "sewage_valve"
                end
                return a }
            hash.[]=(:sewage_valve,lam,false)
        end
                

        unless axi_master.is_a? Hash
            hash.case_record(:axi_master,axi_master)
        else
            # hash.new_index(:axi_master)= lambda { a = Axi4.new(axi_master);a.name = "axi_master";return a }
            # hash[:axi_master] = lambda { a = Axi4.new(axi_master);a.name = "axi_master";return a }
            raise TdlError.new('idata_pool_axi4 Axi4 axi_master TdlHash cant include Proc') if axi_master.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Axi4.new(axi_master)
                unless axi_master[:name]
                    a.name = "axi_master"
                end
                return a }
            hash.[]=(:axi_master,lam,false)
        end
                

        hash.push_to_module_stack(Axi4,:idata_pool_axi4)
        hash.open_error = true
        return hash
    end
end
