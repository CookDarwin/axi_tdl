class  Logic

    def latency(count:1,clock:nil,reset:nil)

        unless clock
            sclk = @__clock__
        else
            sclk = clock
        end

        unless reset
            srst = @__reset__
        else
            srst = reset
        end

        unless sclk
            raise TdlError.new("latency clock is nil")
        end 

        unless srst
            raise TdlError.new('latency reset is nil')
        end

        # new_l = Logic.new(name:" #{signal(square:false)}_lat",dsize:self.dsize)
        new_l = belong_to_module.Def.logic(name:"#{signal(square:false)}_lat",dsize:self.dsize)
        str = %Q{
//----->> #{signal} LAST DELAY <<------------------
latency #(
    .LAT    (#{count}),
    .DSIZE  (#{dsize})
)#{signal(square:false)}_lat#{count}_inst(
    #{sclk},
    #{srst},
    #{signal},
    #{new_l.signal}
);
//-----<< #{signal} LAST DELAY >>------------------
}

        # @@logic_expression << lambda{ str }
        # GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression << lambda{ str }
        belong_to_module.Logic_draw << str

        return new_l
    end

    def cross_clock(clock:nil,name: false)
        raise TdlError.new("\n #{signal} CROSS CLOCK <clock = nil> \n") unless clock

        # new_l = Logic.new(name:"#{signal(square:false)}_cc",dsize:self.dsize)
        new_l = nil
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
            unless name
                new_l = belong_to_module.Def.logic(name:"#{signal(square:false)}_cc",dsize:self.dsize)
            else
                new_l = belong_to_module.Def.logic(name: name.to_s ,dsize:self.dsize)
            end
            str = %Q{
//----->> #{signal} cross clock <<------------------
cross_clk_sync #(
	.LAT   (2      ),
	.DSIZE (#{dsize})
)#{signal(square:false)}_cross_clk_#{name ? name.to_s : '' }inst(
/* input              */ .clk       (#{align_signal(clock)}),
/* input              */ .rst_n     (#{align_signal("1'b1")}),
/* input [DSIZE-1:0]  */ .d         (#{align_signal(self)}),
/* output[DSIZE-1:0]  */ .q         (#{align_signal(new_l)})
);
//-----<< #{signal} cross clock >>------------------
}
            # @@logic_expression << lambda{ str }
            # GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression << lambda{ str }
            belong_to_module.Logic_draw << str
        end

        return new_l
    end

    def broaden_and_cross_clk(phase: "POSITIVE",len:4,lat:2,wclk: nil,rreset: "1'b1".to_nq,rclk: nil,wreset: "1'b1".to_nq,name: nil)
        if wclk.nil? || rclk.nil?
            raise TdlError.new("\n #{self.to_s} BROADEN_AND_CROSS_CLK <clock = nil> \n")
        end
        new_l = belong_to_module.Def().logic(name:name || "broaden_and_cross_clk_#{globle_random_name_flag()}",dsize:1)
        large_name_len(phase,len,wclk,wreset,rclk,rreset)
body =
"
broaden_and_cross_clk #(
    .PHASE     (#{align_signal(phase)}),  //POSITIVE NEGATIVE
    .LEN       (#{align_signal(len)}),
    .LAT       (#{align_signal(lat)})
)#{new_l.signal}_inst_#{globle_random_name_flag()}(
/* input    */  .rclk       (#{align_signal(rclk,q_mark=false)}),
/* input    */  .rd_rst_n   (#{align_signal(rreset,q_mark=false)}),
/* input    */  .wclk       (#{align_signal(wclk,q_mark=false)}),
/* input    */  .wr_rst_n   (#{align_signal(wreset,q_mark=false)}),
/* input    */  .d          (#{align_signal(self,q_mark=false)}),
/* output   */  .q          (#{align_signal(new_l,q_mark=false)})
);
"
        belong_to_module.Logic_draw << page(tag:"BROADEN_AND_CROSS_CLK",body:body)

        return new_l
    end

end

module  CtrlLogic

    def latency(num,clock:nil,reset:nil)


        # new_l = Logic.new(name:"lat",dsize:1)
        new_l = self.logic(name:"lat",dsize:1)
        new_l.clock = clock
        new_l.reset = reset
        if reset
            reset_str = reset.low_signal
        else
            reset_str = "1'b1"
        end

        str = %Q{
//----->> #{self.to_s} LAST DELAY <<------------------
latency #(
    .LAT    (#{num}),
    .DSIZE  (1)
)#{new_l.signal}_lat_#{globle_random_name_flag()}(
    #{clock},
    #{reset_str},
    #{self.to_s},
    #{new_l.signal}
);
//-----<< #{self.to_s} LAST DELAY >>------------------
}

        # Logic.class_variable_get("@@logic_expression") << lambda{ str }
        belong_to_module.Logic_draw << str

        return new_l
    end

    def cross_clock(clock:nil,dsize:1,belong_to_module:nil,reset:"1'b1".to_nq,name:nil)
        raise TdlError.new("\n #{self.to_s} CROSS CLOCK <clock = nil> \n") unless clock

        # new_l = Logic.new(name:"crock_clk",dsize:self.dsize)
        # new_l = self.logic(name:"crock_clk",dsize:self.dsize)
        new_l = belong_to_module.Def().logic(name:name || "crock_clk_#{globle_random_name_flag()}",dsize:dsize)
        str = %Q{
//----->> #{self.to_s} cross clock <<------------------
cross_clk_sync #(
	.LAT   (2      ),
	.DSIZE (#{dsize})
)#{new_l.signal}_cross_clk_inst__#{globle_random_name_flag()}(
/* input              */ .clk       (#{align_signal(clock)}),
/* input              */ .rst_n     (#{align_signal(reset)}),
/* input [DSIZE-1:0]  */ .d         (#{align_signal(self)}),
/* output[DSIZE-1:0]  */ .q         (#{align_signal(new_l)})
);
//-----<< #{self.to_s} cross clock >>------------------
}
        # Logic.class_variable_get("@@logic_expression") << lambda{ str }
        belong_to_module.Logic_draw << str
        return new_l
    end

    def broaden_and_cross_clk(phase:"POSITIVE",len:4,lat:2,wclk:nil,rreset:"1'b1".to_nq,rclk:nil,wreset:"1'b1".to_nq,belong_to_module:nil,name:nil)
        if wclk.nil? || rclk.nil?
            raise TdlError.new("\n #{self.to_s} BROADEN_AND_CROSS_CLK <clock = nil> \n")
        end
        new_l = belong_to_module.Def().logic(name:name || "broaden_and_cross_clk_#{globle_random_name_flag()}",dsize:1)
        large_name_len(phase,len,wclk,wreset,rclk,rreset)
body =
"
broaden_and_cross_clk #(
	.PHASE     (#{align_signal(phase)}),  //POSITIVE NEGATIVE
	.LEN       (#{align_signal(len)}),
	.LAT       (#{align_signal(lat)})
)#{new_l.signal}_inst_#{globle_random_name_flag()}(
/* input    */  .rclk       (#{align_signal(rclk,q_mark=false)}),
/* input    */  .rd_rst_n   (#{align_signal(rreset,q_mark=false)}),
/* input    */  .wclk       (#{align_signal(wclk,q_mark=false)}),
/* input    */  .wr_rst_n   (#{align_signal(wreset,q_mark=false)}),
/* input    */  .d          (#{align_signal(self,q_mark=false)}),
/* output   */  .q          (#{align_signal(new_l,q_mark=false)})
);
"
        belong_to_module.Logic_draw << page(tag:"BROADEN_AND_CROSS_CLK",body:body)

        return new_l
    end

end

class String
    include CtrlLogic
end
