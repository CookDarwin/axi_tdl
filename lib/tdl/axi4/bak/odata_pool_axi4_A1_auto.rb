
#2017-12-27 10:16:00 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class Axi4


    def _odata_pool_axi4_a1(
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        out_axis:"out_axis",
        axi_master:"axi_master"
    )

        Tdl.add_to_all_file_paths(['odata_pool_axi4_a1','../../axi/AXI4/odata_pool_axi4_A1.sv'])
        return_stream = self
        
        out_axis = AxiStream.same_name_socket(:to_down,mix=true,out_axis) unless out_axis.is_a? String
        axi_master = Axi4.same_name_socket(:mirror,mix=true,axi_master) unless axi_master.is_a? String
        
        
        

         @instance_draw_stack << lambda { _odata_pool_axi4_a1_draw(
            source_addr:source_addr,
            size:size,
            valid:valid,
            ready:ready,
            out_axis:out_axis,
            axi_master:axi_master) }
        return return_stream
    end

    def _odata_pool_axi4_a1_draw(
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        out_axis:"out_axis",
        axi_master:"axi_master"
    )

        large_name_len(
            source_addr,
            size,
            valid,
            ready,
            out_axis,
            axi_master
        )
"
// FilePath:::../../axi/AXI4/odata_pool_axi4_A1.sv
odata_pool_axi4_A1 odata_pool_axi4_A1_#{signal}_inst(
/*  input  [31:0]        */ .source_addr (#{align_signal(source_addr,q_mark=false)}),
/*  input  [31:0]        */ .size        (#{align_signal(size,q_mark=false)}),
/*  input                */ .valid       (#{align_signal(valid,q_mark=false)}),
/*  output               */ .ready       (#{align_signal(ready,q_mark=false)}),
/*  axi_stream_inf.master*/ .out_axis    (#{align_signal(out_axis,q_mark=false)}),
/*  axi_inf.master_rd    */ .axi_master  (#{align_signal(axi_master,q_mark=false)})
);
"
    end
    
    def self.odata_pool_axi4_a1(
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        out_axis:"out_axis",
        axi_master:"axi_master"
    )
        return_stream = nil
        
        
        Axi4.NC._odata_pool_axi4_a1(
            source_addr:source_addr,
                size:size,
                valid:valid,
                ready:ready,
                out_axis:out_axis,
                axi_master:axi_master)
        return return_stream
    end
        

end


class TdlTest

    def self.test_odata_pool_axi4_a1
        c0 = Clock.new(name:"odata_pool_axi4_a1_clk",freqM:148.5)
        r0 = Reset.new(name:"odata_pool_axi4_a1_rst_n",active:"low")

        source_addr = Logic.new(name:"source_addr")
        size = Logic.new(name:"size")
        valid = Logic.new(name:"valid")
        ready = Logic.new(name:"ready")
        out_axis = AxiStream.new(name:"out_axis",clock:c0,reset:r0)
        axi_master = Axi4.new(name:"axi_master",clock:c0,reset:r0)
        
        
        Axi4.odata_pool_axi4_a1(
            source_addr:source_addr,
            size:size,
            valid:valid,
            ready:ready,
            out_axis:out_axis,
            axi_master:axi_master)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_odata_pool_axi4_a1(
        source_addr:"source_addr",
        size:"size",
        valid:"valid",
        ready:"ready",
        out_axis:"out_axis",
        axi_master:"axi_master")
        hash = TdlHash.new
        
        unless source_addr.is_a? Hash
            hash.case_record(:source_addr,source_addr)
        else
            # hash.new_index(:source_addr)= lambda { a = Logic.new(source_addr);a.name = "source_addr";return a }
            # hash[:source_addr] = lambda { a = Logic.new(source_addr);a.name = "source_addr";return a }
            raise TdlError.new('odata_pool_axi4_a1 Logic source_addr TdlHash cant include Proc') if source_addr.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('odata_pool_axi4_a1 Logic size TdlHash cant include Proc') if size.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('odata_pool_axi4_a1 Logic valid TdlHash cant include Proc') if valid.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('odata_pool_axi4_a1 Logic ready TdlHash cant include Proc') if ready.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(ready)
                unless ready[:name]
                    a.name = "ready"
                end
                return a }
            hash.[]=(:ready,lam,false)
        end
                

        unless out_axis.is_a? Hash
            hash.case_record(:out_axis,out_axis)
        else
            # hash.new_index(:out_axis)= lambda { a = AxiStream.new(out_axis);a.name = "out_axis";return a }
            # hash[:out_axis] = lambda { a = AxiStream.new(out_axis);a.name = "out_axis";return a }
            raise TdlError.new('odata_pool_axi4_a1 AxiStream out_axis TdlHash cant include Proc') if out_axis.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(out_axis)
                unless out_axis[:name]
                    a.name = "out_axis"
                end
                return a }
            hash.[]=(:out_axis,lam,false)
        end
                

        unless axi_master.is_a? Hash
            hash.case_record(:axi_master,axi_master)
        else
            # hash.new_index(:axi_master)= lambda { a = Axi4.new(axi_master);a.name = "axi_master";return a }
            # hash[:axi_master] = lambda { a = Axi4.new(axi_master);a.name = "axi_master";return a }
            raise TdlError.new('odata_pool_axi4_a1 Axi4 axi_master TdlHash cant include Proc') if axi_master.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Axi4.new(axi_master)
                unless axi_master[:name]
                    a.name = "axi_master"
                end
                return a }
            hash.[]=(:axi_master,lam,false)
        end
                

        hash.push_to_module_stack(Axi4,:odata_pool_axi4_a1)
        hash.open_error = true
        return hash
    end
end
