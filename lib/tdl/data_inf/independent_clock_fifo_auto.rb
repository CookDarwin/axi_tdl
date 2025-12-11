
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class DataInf


    def _independent_clock_fifo(
        depth:4,
        dsize:8,
        wr_clk:"wr_clk",
        wr_rst_n:"wr_rst_n",
        rd_clk:"rd_clk",
        rd_rst_n:"rd_rst_n",
        wdata:"wdata",
        wr_en:"wr_en",
        rdata:"rdata",
        rd_en:"rd_en",
        empty:"empty",
        full:"full"
    )

        Tdl.add_to_all_file_paths('independent_clock_fifo','../../axi/common_fifo/independent_clock_fifo.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['independent_clock_fifo','../../axi/common_fifo/independent_clock_fifo.sv'])
        return_stream = self
        

        
        
        


        belong_to_module.DataInf_draw << _independent_clock_fifo_draw(
            depth:depth,
            dsize:dsize,
            wr_clk:wr_clk,
            wr_rst_n:wr_rst_n,
            rd_clk:rd_clk,
            rd_rst_n:rd_rst_n,
            wdata:wdata,
            wr_en:wr_en,
            rdata:rdata,
            rd_en:rd_en,
            empty:empty,
            full:full)
        return return_stream
    end

    private

    def _independent_clock_fifo_draw(
        depth:4,
        dsize:8,
        wr_clk:"wr_clk",
        wr_rst_n:"wr_rst_n",
        rd_clk:"rd_clk",
        rd_rst_n:"rd_rst_n",
        wdata:"wdata",
        wr_en:"wr_en",
        rdata:"rdata",
        rd_en:"rd_en",
        empty:"empty",
        full:"full"
    )

        large_name_len(
            depth,
            dsize,
            wr_clk,
            wr_rst_n,
            rd_clk,
            rd_rst_n,
            wdata,
            wr_en,
            rdata,
            rd_en,
            empty,
            full
        )
        instance_name = "independent_clock_fifo_#{signal}_inst"
"
// FilePath:::../../axi/common_fifo/independent_clock_fifo.sv
independent_clock_fifo#(
    .DEPTH    (#{align_signal(depth)}),
    .DSIZE    (#{align_signal(dsize)})
) #{instance_name}(
/*  input             */ .wr_clk   (#{align_signal(wr_clk,q_mark=false)}),
/*  input             */ .wr_rst_n (#{align_signal(wr_rst_n,q_mark=false)}),
/*  input             */ .rd_clk   (#{align_signal(rd_clk,q_mark=false)}),
/*  input             */ .rd_rst_n (#{align_signal(rd_rst_n,q_mark=false)}),
/*  input  [DSIZE-1:0]*/ .wdata    (#{align_signal(wdata,q_mark=false)}),
/*  input             */ .wr_en    (#{align_signal(wr_en,q_mark=false)}),
/*  output [DSIZE-1:0]*/ .rdata    (#{align_signal(rdata,q_mark=false)}),
/*  input             */ .rd_en    (#{align_signal(rd_en,q_mark=false)}),
/*  output            */ .empty    (#{align_signal(empty,q_mark=false)}),
/*  output            */ .full     (#{align_signal(full,q_mark=false)})
);
"
    end
    
    public

    def self.independent_clock_fifo(
        depth:4,
        dsize:8,
        wr_clk:"wr_clk",
        wr_rst_n:"wr_rst_n",
        rd_clk:"rd_clk",
        rd_rst_n:"rd_rst_n",
        wdata:"wdata",
        wr_en:"wr_en",
        rdata:"rdata",
        rd_en:"rd_en",
        empty:"empty",
        full:"full",
        belong_to_module:nil
        )
        return_stream = nil
        
        
        
        belong_to_module.DataInf_NC._independent_clock_fifo(
            depth:depth,
            dsize:dsize,
            wr_clk:wr_clk,
            wr_rst_n:wr_rst_n,
            rd_clk:rd_clk,
            rd_rst_n:rd_rst_n,
            wdata:wdata,
            wr_en:wr_en,
            rdata:rdata,
            rd_en:rd_en,
            empty:empty,
            full:full)
        return return_stream
    end
        

end

