
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def _wide_axis_to_axi4_wr(
        addr:"addr",
        max_length:"max_length",
        axis_in:"axis_in",
        axi_wr:"axi_wr"
    )

        Tdl.add_to_all_file_paths('wide_axis_to_axi4_wr','../../axi/AXI4/wide_axis_to_axi4_wr.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['wide_axis_to_axi4_wr','../../axi/AXI4/wide_axis_to_axi4_wr.sv'])
        return_stream = self

        axis_in = AxiStream.same_name_socket(:from_up,mix=true,axis_in,nil,belong_to_module) unless axis_in.is_a? String
        axi_wr = Axi4.same_name_socket(:mirror,mix=true,axi_wr,nil,belong_to_module) unless axi_wr.is_a? String





        belong_to_module.AxiStream_draw << _wide_axis_to_axi4_wr_draw(
            addr:addr,
            max_length:max_length,
            axis_in:axis_in,
            axi_wr:axi_wr)
        return return_stream
    end

    private

    def _wide_axis_to_axi4_wr_draw(
        addr:"addr",
        max_length:"max_length",
        axis_in:"axis_in",
        axi_wr:"axi_wr"
    )

        large_name_len(
            addr,
            max_length,
            axis_in,
            axi_wr
        )
        instance_name = "wide_axis_to_axi4_wr_#{signal}_inst"
"
// FilePath:::../../axi/AXI4/wide_axis_to_axi4_wr.sv
wide_axis_to_axi4_wr #{instance_name}(
/*  input  [31:0]        */ .addr       (#{align_signal(addr,q_mark=false)}),
/*  input  [31:0]        */ .max_length (#{align_signal(max_length,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .axis_in    (#{align_signal(axis_in,q_mark=false)}),
/*  axi_inf.master_wr    */ .axi_wr     (#{align_signal(axi_wr,q_mark=false)})
);
"
    end

    public

    def self.wide_axis_to_axi4_wr(
        addr:"addr",
        max_length:"max_length",
        axis_in:"axis_in",
        axi_wr:"axi_wr",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axis_in].first.belong_to_module unless belong_to_module


        belong_to_module.AxiStream_NC._wide_axis_to_axi4_wr(
            addr:addr,
            max_length:max_length,
            axis_in:axis_in,
            axi_wr:axi_wr)
        return return_stream
    end


end
