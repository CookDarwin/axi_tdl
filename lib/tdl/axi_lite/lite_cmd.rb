
class AxiLite

    def EvalList(trigger:"1'b1",done:"",&block)
        Tdl.add_to_all_file_paths('gen_axi_lite_ctrl','..\..\axi\AXI_Lite\gen_axi_lite_ctrl.sv')
        Tdl.add_to_all_file_paths('gen_axi_lite_ctrl_verc','..\..\axi\AXI_Lite\gen_axi_lite_ctrl_verc.sv')
        @__cmds__ = []
        with_main_funcs(
            {
                LITE_WR:method(:cmd_wr_exec),
                LITE_RD_MEET:method(:cmd_read_meet_exec),
                LITE_RD_MEET_KEEP:method(:cmd_read_meet_keep_exec),
                LITE_RD:method(:cmd_read_exec)
            },&block)

        belong_to_module.AxiLite_draw << cmd_list_draw(@__cmds__.length,trigger,done,render_cmds)
    end

    def cmd_list_draw(num,up_trigger,domn_trigger,ex_str)
        large_name_len(num,up_trigger,domn_trigger,self)
"
logic [#{signal}.DSIZE-1:0]  lite_rdata_#{signal};
generate
begin:LITE_CMD_#{signal}
Lite_Addr_Data_CMD #(
    .ASIZE      (#{signal}.ASIZE),
    .DSIZE      (#{signal}.DSIZE)
)addrdatac_#{signal} [#{num.to_s}-1:0] ();

// FilePath::: ../../axi/AXI_Lite/gen_axi_lite_ctrl_verc.sv
gen_axi_lite_ctrl_verc #(
    .NUM        (#{num.to_s})
)gen_axi_lite_ctrl_inst_#{signal}(
/*    input                     */  .from_up_trigger    (#{align_signal(up_trigger  ,q_mark=false)}),
/*    output logic              */  .to_domn_trigger    (#{align_signal(domn_trigger,q_mark=false)}),
/*    axi_lite_inf.master       */  .lite               (#{align_signal(self)}),
/*    Lite_Addr_Data_CMD.slaver */  .addrdatac          (addrdatac_#{signal}),
/*    output logic []           */  .lite_rdata         (lite_rdata_#{signal})
);

#{ex_str}
end
endgenerate
"
    end

    def cmd_exec(type: :write,addr:0,data:0,keep:nil)
        if keep
            @__cmds__ << [type,addr,data,keep]
        else
            @__cmds__ << [type,addr,data]
        end
    end

    def cmd_wr_exec(addr,data)
        cmd_exec(type: :write,addr:addr,data:data)
    end

    def cmd_read_exec(addr)
        cmd_exec(type: :read,addr:addr)
    end

    def cmd_read_meet_exec(addr,data)
        cmd_exec(type: :read_meet,addr:addr,data:data)
    end

    def cmd_read_meet_keep_exec(addr,data,keep)
        cmd_exec(type: :read_meet_keep,addr:addr,data:data,keep:keep)
    end

    private

    def render_cmds
        str_array = []
        @__cmds__.each_index do |index|
            str_array << render_cmd(index:index,type:@__cmds__[index][0],addr:@__cmds__[index][1],data:@__cmds__[index][2],keep:@__cmds__[index][3])
        end
        str_array.join("\n")
    end

    def render_cmd(index:0,type: :write,addr:0,data:0,keep:0)
        case type
        when :write then
            "Lite_Addr_Data_WR WR_CMD_#{index}_inst    (addrdatac_#{signal}[#{index}],#{tohex addr},#{tohex data});"
        when :read_meet then
            "Lite_Addr_Data_RD_MEET RD_MEET_#{index}_inst (addrdatac_#{signal}[#{index}],#{tohex addr},#{tohex data});"
        when :read_meet_keep then
            "Lite_Addr_Data_RD_MEET_KEEP RD_MEET_#{index}_inst (addrdatac_#{signal}[#{index}],#{tohex addr},#{tohex data},#{tohex keep});"
        when :read then
            "Lite_Addr_Data_RD RD_#{index}_inst (addrdatac_#{signal}[#{index}],#{tohex addr});"
        else
            "// No Render CMD #{type}!!!"
        end
    end

    def tohex(num)
        if num.is_a? Integer
            "32'h#{num.to_s(16)}"
        else
            num
        end
    end


end

class AxiLite

    def EvalListStep(clken:nil,trigger:"1'b1",done:"",&block)
        raise TdlError.new("\n LITE Eval List <<clken>> must privoded\n") unless clken
        Tdl.add_to_all_file_paths(['gen_axi_lite_ctrl','..\..\axi\AXI_Lite\gen_axi_lite_ctrl.sv'])
        Tdl.add_to_all_file_paths(['gen_axi_lite_ctrl_verc','..\..\axi\AXI_Lite\gen_axi_lite_ctrl_C1.sv'])
        @__cmds__ = []
        with_main_funcs(
            {
                LITE_WR:method(:cmd_wr_exec),
                LITE_RD_MEET:method(:cmd_read_meet_exec),
                LITE_RD_MEET_KEEP:method(:cmd_read_meet_keep_exec),
                LITE_RD:method(:cmd_read_exec)
            },&block)
        @_step_clken_ = clken
        belong_to_module.AxiLite_draw << cmd_list_draw_step(@__cmds__.length,trigger,done,render_cmds)
    end

    def cmd_list_draw_step(num,up_trigger,domn_trigger,ex_str)
        large_name_len(num,up_trigger,domn_trigger,self,@_step_clken_)
"
logic [#{signal}.DSIZE-1:0]  lite_rdata_#{signal};
generate
begin:LITE_CMD_#{signal}
Lite_Addr_Data_CMD #(
    .ASIZE      (#{signal}.ASIZE),
    .DSIZE      (#{signal}.DSIZE)
)addrdatac_#{signal} [#{num.to_s}-1:0] ();

// FilePath::: ../../axi/AXI_Lite/gen_axi_lite_ctrl_C1.sv
gen_axi_lite_ctrl_C1 #(
    .NUM        (#{num.to_s})
)gen_axi_lite_ctrl_inst_#{signal}(
/*    input                     */  .clk_en             (#{align_signal(@_step_clken_  ,q_mark=false)}),
/*    input                     */  .from_up_trigger    (#{align_signal(up_trigger  ,q_mark=false)}),
/*    output logic              */  .to_domn_trigger    (#{align_signal(domn_trigger,q_mark=false)}),
/*    axi_lite_inf.master       */  .lite               (#{align_signal(self)}),
/*    Lite_Addr_Data_CMD.slaver */  .addrdatac          (addrdatac_#{signal}),
/*    output logic []           */  .lite_rdata         (lite_rdata_#{signal})
);

#{ex_str}
end
endgenerate
"
    end

end
