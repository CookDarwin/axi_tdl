
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class DataInf


    def _clock_rst_verb(
        active:1,
        period_cnt:0,
        rst_hold:5,
        freqm:100,
        clock:"clock",
        rst_x:"rst_x"
    )

        Tdl.add_to_all_file_paths('clock_rst_verb','../../github/public_atom_modules/sim/clock_rst_verb.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['clock_rst_verb','../../github/public_atom_modules/sim/clock_rst_verb.sv'])
        return_stream = self
        

        
        
        


        belong_to_module.DataInf_draw << _clock_rst_verb_draw(
            active:active,
            period_cnt:period_cnt,
            rst_hold:rst_hold,
            freqm:freqm,
            clock:clock,
            rst_x:rst_x)
        return return_stream
    end

    private

    def _clock_rst_verb_draw(
        active:1,
        period_cnt:0,
        rst_hold:5,
        freqm:100,
        clock:"clock",
        rst_x:"rst_x"
    )

        large_name_len(
            active,
            period_cnt,
            rst_hold,
            freqm,
            clock,
            rst_x
        )
        instance_name = "clock_rst_verb_#{signal}_inst"
"
// FilePath:::../../github/public_atom_modules/sim/clock_rst_verb.sv
clock_rst_verb#(
    .ACTIVE        (#{align_signal(active)}),
    .PERIOD_CNT    (#{align_signal(period_cnt)}),
    .RST_HOLD      (#{align_signal(rst_hold)}),
    .FreqM         (#{align_signal(freqm)})
) #{instance_name}(
/*  output */ .clock (#{align_signal(clock,q_mark=false)}),
/*  output */ .rst_x (#{align_signal(rst_x,q_mark=false)})
);
"
    end
    
    public

    def self.clock_rst_verb(
        active:1,
        period_cnt:0,
        rst_hold:5,
        freqm:100,
        clock:"clock",
        rst_x:"rst_x",
        belong_to_module:nil
        )
        return_stream = nil
        
        
        
        belong_to_module.DataInf_NC._clock_rst_verb(
            active:active,
            period_cnt:period_cnt,
            rst_hold:rst_hold,
            freqm:freqm,
            clock:clock,
            rst_x:rst_x)
        return return_stream
    end
        

end

