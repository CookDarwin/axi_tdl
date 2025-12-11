
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def _axis_link_trigger(
        mode:"STREAM",
        dsize:32,
        data:"data",
        trigger_inf:"trigger_inf",
        mirror:"mirror"
    )

        Tdl.add_to_all_file_paths('axis_link_trigger','../../axi/AXI_stream/axis_link_trigger.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axis_link_trigger','../../axi/AXI_stream/axis_link_trigger.sv'])
        return_stream = self
        
        trigger_inf = DataInf_C.same_name_socket(:to_down,mix=true,trigger_inf,nil,belong_to_module) unless trigger_inf.is_a? String
        mirror = AxiStream.same_name_socket(:mirror,mix=true,mirror,nil,belong_to_module) unless mirror.is_a? String
        
        
        


        belong_to_module.AxiStream_draw << _axis_link_trigger_draw(
            mode:mode,
            dsize:dsize,
            data:data,
            trigger_inf:trigger_inf,
            mirror:mirror)
        return return_stream
    end

    private

    def _axis_link_trigger_draw(
        mode:"STREAM",
        dsize:32,
        data:"data",
        trigger_inf:"trigger_inf",
        mirror:"mirror"
    )

        large_name_len(
            mode,
            dsize,
            data,
            trigger_inf,
            mirror
        )
        instance_name = "axis_link_trigger_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axis_link_trigger.sv
axis_link_trigger#(
    .MODE     (#{align_signal(mode)}),
    .DSIZE    (#{align_signal(dsize)})
) #{instance_name}(
/*  input  [DSIZE-1:0]   */ .data        (#{align_signal(data,q_mark=false)}),
/*  data_inf_c.master    */ .trigger_inf (#{align_signal(trigger_inf,q_mark=false)}),
/*  axi_stream_inf.mirror*/ .mirror      (#{align_signal(mirror,q_mark=false)})
);
"
    end
    
    public

    def self.axis_link_trigger(
        mode:"STREAM",
        dsize:32,
        data:"data",
        trigger_inf:"trigger_inf",
        mirror:"mirror",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [mirror].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.AxiStream_NC._axis_link_trigger(
            mode:mode,
            dsize:dsize,
            data:data,
            trigger_inf:trigger_inf,
            mirror:mirror)
        return return_stream
    end
        

end

