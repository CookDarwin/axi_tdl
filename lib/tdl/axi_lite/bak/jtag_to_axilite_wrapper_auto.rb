
#2018-01-02 14:17:20 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiLite


    def _jtag_to_axilite_wrapper(
        lite:"lite"
    )

        # Tdl.add_to_all_file_paths(['jtag_to_axilite_wrapper','../../axi/AXI_Lite/common_configure_reg_interface/jtag_to_axilite_wrapper.sv'])
        GlobalParam.CurrTdlModule.add_to_all_file_paths(['jtag_to_axilite_wrapper','../../axi/AXI_Lite/common_configure_reg_interface/jtag_to_axilite_wrapper.sv'])
        return_stream = self
        
        lite = AxiLite.same_name_socket(:to_down,mix=true,lite) unless lite.is_a? String
        
        
        

        # @instance_draw_stack << lambda { _jtag_to_axilite_wrapper_draw(
        #    lite:lite,
            #thash:GlobalParam.CurrHash) }
        @instance_draw_stack << _jtag_to_axilite_wrapper_draw(
            lite:lite,
            thash:GlobalParam.CurrHash)
        return return_stream
    end

    def _jtag_to_axilite_wrapper_draw(
        lite:"lite",
        thash:nil
    )

        large_name_len(
            lite
        )
        instance_name = "jtag_to_axilite_wrapper_#{signal}_inst"
        thash.instance_name = instance_name if thash
        GlobalParam.LastModuleInstName = instance_name 
"
// FilePath:::../../axi/AXI_Lite/common_configure_reg_interface/jtag_to_axilite_wrapper.sv
jtag_to_axilite_wrapper #{instance_name}(
/*  axi_lite_inf.master*/ .lite (#{align_signal(lite,q_mark=false)})
);
"
    end
    
    def self.jtag_to_axilite_wrapper(
        lite:"lite"
    )
        return_stream = nil
        
        
        AxiLite.NC._jtag_to_axilite_wrapper(
            lite:lite)
        return return_stream
    end
        

end


class TdlTest

    def self.test_jtag_to_axilite_wrapper
        c0 = Clock.new(name:"jtag_to_axilite_wrapper_clk",freqM:148.5)
        r0 = Reset.new(name:"jtag_to_axilite_wrapper_rst_n",active:"low")

        lite = AxiLite.new(name:"lite",clock:c0,reset:r0)
        
        
        AxiLite.jtag_to_axilite_wrapper(
            lite:lite)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_jtag_to_axilite_wrapper(
        lite:"lite")
        hash = TdlHash.new
        
        unless lite.is_a? Hash
            hash.case_record(:lite,lite)
        else
            # hash.new_index(:lite)= lambda { a = AxiLite.new(lite);a.name = "lite";return a }
            # hash[:lite] = lambda { a = AxiLite.new(lite);a.name = "lite";return a }
            raise TdlError.new('jtag_to_axilite_wrapper AxiLite lite TdlHash cant include Proc') if lite.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiLite.new(lite)
                unless lite[:name]
                    a.name = "lite"
                end
                return a }
            hash.[]=(:lite,lam,false)
        end
                

        if block_given?
            yield hash
        end

        hash.push_to_module_stack(AxiLite,:jtag_to_axilite_wrapper)
        hash.open_error = true
        return hash
    end
end
