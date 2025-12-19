
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiLite


    def axi_lite_master_empty(
        lite:"lite",
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('axi_lite_master_empty','../../axi/AXI_Lite/axi_lite_master_empty.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axi_lite_master_empty','../../axi/AXI_Lite/axi_lite_master_empty.sv'])
        return_stream = self
        
        lite = AxiLite.same_name_socket(:to_down,mix=true,lite,nil,belong_to_module) unless lite.is_a? String
        
        
        unless self.eql? belong_to_module.AxiLite_NC
            lite = self
        else
            if down_stream
                lite = down_stream
            end
        end


        belong_to_module.AxiLite_draw << axi_lite_master_empty_draw(
            lite:lite,
            down_stream:down_stream)
        return return_stream
    end

    private

    def axi_lite_master_empty_draw(
        lite:"lite",
        down_stream:nil
    )

        large_name_len(
            lite
        )
        instance_name = "axi_lite_master_empty_#{signal}_inst"
"
// FilePath:::../../axi/AXI_Lite/axi_lite_master_empty.sv
axi_lite_master_empty #{instance_name}(
/*  axi_lite_inf.master*/ .lite (#{align_signal(lite,q_mark=false)})
);
"
    end
    
    public

    def self.axi_lite_master_empty(
        lite:"lite",
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [lite].first.belong_to_module unless belong_to_module
        
        
        
        if down_stream.is_a? AxiLite
            down_stream.axi_lite_master_empty(
                lite:lite,
                down_stream:down_stream)
        elsif lite.is_a? AxiLite
            lite.axi_lite_master_empty(
                lite:lite,
                down_stream:down_stream)
        else
            belong_to_module.AxiLite_NC.axi_lite_master_empty(
                lite:lite,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

