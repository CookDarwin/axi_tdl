
#2017-07-27 16:22:37 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class Axi4


    def idata_pool_axi4(dsize:8,source_addr:"source_addr",size:"size",valid:"valid",ready:"ready",last_drop:"last_drop",data:"data",empty:"empty",wr_en:"wr_en",sewage_valve:"sewage_valve",axi_master:"axi_master",down_stream:nil)
        return_stream = self
        
        
        axi_master = self

        $_draw = lambda { idata_pool_axi4_draw(dsize:dsize,source_addr:source_addr,size:size,valid:valid,ready:ready,last_drop:last_drop,data:data,empty:empty,wr_en:wr_en,sewage_valve:sewage_valve,axi_master:axi_master,down_stream:down_stream) }
        @correlation_proc += $_draw.call
        return return_stream
    end

    def idata_pool_axi4_draw(dsize:8,source_addr:"source_addr",size:"size",valid:"valid",ready:"ready",last_drop:"last_drop",data:"data",empty:"empty",wr_en:"wr_en",sewage_valve:"sewage_valve",axi_master:"axi_master",down_stream:nil)
        large_name_len(dsize,source_addr,size,valid,ready,last_drop,data,empty,wr_en,sewage_valve,axi_master)
"
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
    
    def self.idata_pool_axi4(dsize:8,source_addr:"source_addr",size:"size",valid:"valid",ready:"ready",last_drop:"last_drop",data:"data",empty:"empty",wr_en:"wr_en",sewage_valve:"sewage_valve",axi_master:"axi_master",down_stream:nil)
        return_stream = nil
        
        
        
        if down_stream.is_a? Axi4
            down_stream.idata_pool_axi4(dsize:dsize,source_addr:source_addr,size:size,valid:valid,ready:ready,last_drop:last_drop,data:data,empty:empty,wr_en:wr_en,sewage_valve:sewage_valve,axi_master:axi_master,down_stream:down_stream)
        elsif axi_master.is_a? Axi4
            axi_master.idata_pool_axi4(dsize:dsize,source_addr:source_addr,size:size,valid:valid,ready:ready,last_drop:last_drop,data:data,empty:empty,wr_en:wr_en,sewage_valve:sewage_valve,axi_master:axi_master,down_stream:down_stream)
        else
            NC.idata_pool_axi4(dsize:dsize,source_addr:source_addr,size:size,valid:valid,ready:ready,last_drop:last_drop,data:data,empty:empty,wr_en:wr_en,sewage_valve:sewage_valve,axi_master:axi_master,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_idata_pool_axi4
        c0 = Clock.new(name:"idata_pool_axi4_clk",freqM:148.5)
        r0 = Reset.new(name:"idata_pool_axi4_rst_n",active:"low")

        Parameter.new(name:"dsize",value:8)
        Logic.new(name:"source_addr")
        Logic.new(name:"size")
        Logic.new(name:"valid")
        Logic.new(name:"ready")
        Logic.new(name:"last_drop")
        Logic.new(name:"data")
        Logic.new(name:"empty")
        Logic.new(name:"wr_en")
        Logic.new(name:"sewage_valve")
        Axi4.new(name:"axi_master",clock:c0,reset:r0)
        
        down_stream = axi_master
        Axi4.idata_pool_axi4(dsize:dsize,source_addr:source_addr,size:size,valid:valid,ready:ready,last_drop:last_drop,data:data,empty:empty,wr_en:wr_en,sewage_valve:sewage_valve,axi_master:axi_master)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_idata_pool_axi4(dsize:8,
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
                

        unless source_addr.is_a? Hash
            # hash.new_index(:source_addr) = source_addr
            if source_addr.is_a? BaseElm
                hash.[]=(:source_addr,source_addr,true)
            else
                hash.[]=(:source_addr,source_addr,false)
            end
        else
            # hash.new_index(:source_addr)= lambda { a = Logic.new(source_addr);a.name = "source_addr";return a }
            # hash[:source_addr] = lambda { a = Logic.new(source_addr);a.name = "source_addr";return a }
            lam = lambda {
                a = Logic.new(source_addr)
                unless source_addr[:name]
                    a.name = "source_addr"
                end
                return a }
            hash.[]=(:source_addr,lam,false)
        end
                

        unless size.is_a? Hash
            # hash.new_index(:size) = size
            if size.is_a? BaseElm
                hash.[]=(:size,size,true)
            else
                hash.[]=(:size,size,false)
            end
        else
            # hash.new_index(:size)= lambda { a = Logic.new(size);a.name = "size";return a }
            # hash[:size] = lambda { a = Logic.new(size);a.name = "size";return a }
            lam = lambda {
                a = Logic.new(size)
                unless size[:name]
                    a.name = "size"
                end
                return a }
            hash.[]=(:size,lam,false)
        end
                

        unless valid.is_a? Hash
            # hash.new_index(:valid) = valid
            if valid.is_a? BaseElm
                hash.[]=(:valid,valid,true)
            else
                hash.[]=(:valid,valid,false)
            end
        else
            # hash.new_index(:valid)= lambda { a = Logic.new(valid);a.name = "valid";return a }
            # hash[:valid] = lambda { a = Logic.new(valid);a.name = "valid";return a }
            lam = lambda {
                a = Logic.new(valid)
                unless valid[:name]
                    a.name = "valid"
                end
                return a }
            hash.[]=(:valid,lam,false)
        end
                

        unless ready.is_a? Hash
            # hash.new_index(:ready) = ready
            if ready.is_a? BaseElm
                hash.[]=(:ready,ready,true)
            else
                hash.[]=(:ready,ready,false)
            end
        else
            # hash.new_index(:ready)= lambda { a = Logic.new(ready);a.name = "ready";return a }
            # hash[:ready] = lambda { a = Logic.new(ready);a.name = "ready";return a }
            lam = lambda {
                a = Logic.new(ready)
                unless ready[:name]
                    a.name = "ready"
                end
                return a }
            hash.[]=(:ready,lam,false)
        end
                

        unless last_drop.is_a? Hash
            # hash.new_index(:last_drop) = last_drop
            if last_drop.is_a? BaseElm
                hash.[]=(:last_drop,last_drop,true)
            else
                hash.[]=(:last_drop,last_drop,false)
            end
        else
            # hash.new_index(:last_drop)= lambda { a = Logic.new(last_drop);a.name = "last_drop";return a }
            # hash[:last_drop] = lambda { a = Logic.new(last_drop);a.name = "last_drop";return a }
            lam = lambda {
                a = Logic.new(last_drop)
                unless last_drop[:name]
                    a.name = "last_drop"
                end
                return a }
            hash.[]=(:last_drop,lam,false)
        end
                

        unless data.is_a? Hash
            # hash.new_index(:data) = data
            if data.is_a? BaseElm
                hash.[]=(:data,data,true)
            else
                hash.[]=(:data,data,false)
            end
        else
            # hash.new_index(:data)= lambda { a = Logic.new(data);a.name = "data";return a }
            # hash[:data] = lambda { a = Logic.new(data);a.name = "data";return a }
            lam = lambda {
                a = Logic.new(data)
                unless data[:name]
                    a.name = "data"
                end
                return a }
            hash.[]=(:data,lam,false)
        end
                

        unless empty.is_a? Hash
            # hash.new_index(:empty) = empty
            if empty.is_a? BaseElm
                hash.[]=(:empty,empty,true)
            else
                hash.[]=(:empty,empty,false)
            end
        else
            # hash.new_index(:empty)= lambda { a = Logic.new(empty);a.name = "empty";return a }
            # hash[:empty] = lambda { a = Logic.new(empty);a.name = "empty";return a }
            lam = lambda {
                a = Logic.new(empty)
                unless empty[:name]
                    a.name = "empty"
                end
                return a }
            hash.[]=(:empty,lam,false)
        end
                

        unless wr_en.is_a? Hash
            # hash.new_index(:wr_en) = wr_en
            if wr_en.is_a? BaseElm
                hash.[]=(:wr_en,wr_en,true)
            else
                hash.[]=(:wr_en,wr_en,false)
            end
        else
            # hash.new_index(:wr_en)= lambda { a = Logic.new(wr_en);a.name = "wr_en";return a }
            # hash[:wr_en] = lambda { a = Logic.new(wr_en);a.name = "wr_en";return a }
            lam = lambda {
                a = Logic.new(wr_en)
                unless wr_en[:name]
                    a.name = "wr_en"
                end
                return a }
            hash.[]=(:wr_en,lam,false)
        end
                

        unless sewage_valve.is_a? Hash
            # hash.new_index(:sewage_valve) = sewage_valve
            if sewage_valve.is_a? BaseElm
                hash.[]=(:sewage_valve,sewage_valve,true)
            else
                hash.[]=(:sewage_valve,sewage_valve,false)
            end
        else
            # hash.new_index(:sewage_valve)= lambda { a = Logic.new(sewage_valve);a.name = "sewage_valve";return a }
            # hash[:sewage_valve] = lambda { a = Logic.new(sewage_valve);a.name = "sewage_valve";return a }
            lam = lambda {
                a = Logic.new(sewage_valve)
                unless sewage_valve[:name]
                    a.name = "sewage_valve"
                end
                return a }
            hash.[]=(:sewage_valve,lam,false)
        end
                

        unless axi_master.is_a? Hash
            # hash.new_index(:axi_master) = axi_master
            if axi_master.is_a? BaseElm
                hash.[]=(:axi_master,axi_master,true)
            else
                hash.[]=(:axi_master,axi_master,false)
            end
        else
            # hash.new_index(:axi_master)= lambda { a = Axi4.new(axi_master);a.name = "axi_master";return a }
            # hash[:axi_master] = lambda { a = Axi4.new(axi_master);a.name = "axi_master";return a }
            lam = lambda {
                a = Axi4.new(axi_master)
                unless axi_master[:name]
                    a.name = "axi_master"
                end
                return a }
            hash.[]=(:axi_master,lam,false)
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
            hash.check_use("idata_pool_axi4")
            Axi4.idata_pool_axi4(hash)
        }
        return hash
    end
end
