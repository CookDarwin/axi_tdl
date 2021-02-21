
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiLite


    def _axi_lite_slaver_empty(
        lite:"lite",
        up_stream:nil
    )

        Tdl.add_to_all_file_paths('axi_lite_slaver_empty','../../axi/AXI_Lite/axi_lite_slaver_empty.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axi_lite_slaver_empty','../../axi/AXI_Lite/axi_lite_slaver_empty.sv'])
        return_stream = self
        
        lite = AxiLite.same_name_socket(:from_up,mix=true,lite,nil,belong_to_module) unless lite.is_a? String
        
        lite = up_stream if up_stream
        


        belong_to_module.AxiLite_draw << _axi_lite_slaver_empty_draw(
            lite:lite,
            up_stream:up_stream)
        return return_stream
    end

    private

    def _axi_lite_slaver_empty_draw(
        lite:"lite",
        up_stream:nil
    )

        large_name_len(
            lite
        )
        instance_name = "axi_lite_slaver_empty_#{signal}_inst"
"
// FilePath:::../../axi/AXI_Lite/axi_lite_slaver_empty.sv
axi_lite_slaver_empty #{instance_name}(
/*  axi_lite_inf.slaver*/ .lite (#{align_signal(lite,q_mark=false)})
);
"
    end
    
    public

    def self.axi_lite_slaver_empty(
        lite:"lite",
        up_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [lite].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.AxiLite_NC._axi_lite_slaver_empty(
            lite:lite,
            up_stream:up_stream)
        return return_stream
    end
        

end

