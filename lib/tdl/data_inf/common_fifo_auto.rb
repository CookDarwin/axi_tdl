
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class DataInf


    def _common_fifo(
        depth:4,
        dsize:8,
        csize:NqString.new('$clog2(DEPTH+1)'),
        clock:"clock",
        rst_n:"rst_n",
        wdata:"wdata",
        wr_en:"wr_en",
        rdata:"rdata",
        rd_en:"rd_en",
        count:"count",
        empty:"empty",
        full:"full"
    )

        Tdl.add_to_all_file_paths('common_fifo','../../axi/common_fifo/common_fifo.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['common_fifo','../../axi/common_fifo/common_fifo.sv'])
        return_stream = self
        

        
        
        


        belong_to_module.DataInf_draw << _common_fifo_draw(
            depth:depth,
            dsize:dsize,
            csize:csize,
            clock:clock,
            rst_n:rst_n,
            wdata:wdata,
            wr_en:wr_en,
            rdata:rdata,
            rd_en:rd_en,
            count:count,
            empty:empty,
            full:full)
        return return_stream
    end

    private

    def _common_fifo_draw(
        depth:4,
        dsize:8,
        csize:NqString.new('$clog2(DEPTH+1)'),
        clock:"clock",
        rst_n:"rst_n",
        wdata:"wdata",
        wr_en:"wr_en",
        rdata:"rdata",
        rd_en:"rd_en",
        count:"count",
        empty:"empty",
        full:"full"
    )

        large_name_len(
            depth,
            dsize,
            csize,
            clock,
            rst_n,
            wdata,
            wr_en,
            rdata,
            rd_en,
            count,
            empty,
            full
        )
        instance_name = "common_fifo_#{signal}_inst"
"
// FilePath:::../../axi/common_fifo/common_fifo.sv
common_fifo#(
    .DEPTH    (#{align_signal(depth)}),
    .DSIZE    (#{align_signal(dsize)}),
    .CSIZE    (#{align_signal(csize)})
) #{instance_name}(
/*  input             */ .clock (#{align_signal(clock,q_mark=false)}),
/*  input             */ .rst_n (#{align_signal(rst_n,q_mark=false)}),
/*  input  [DSIZE-1:0]*/ .wdata (#{align_signal(wdata,q_mark=false)}),
/*  input             */ .wr_en (#{align_signal(wr_en,q_mark=false)}),
/*  output [DSIZE-1:0]*/ .rdata (#{align_signal(rdata,q_mark=false)}),
/*  input             */ .rd_en (#{align_signal(rd_en,q_mark=false)}),
/*  output [CSIZE-1:0]*/ .count (#{align_signal(count,q_mark=false)}),
/*  output            */ .empty (#{align_signal(empty,q_mark=false)}),
/*  output            */ .full  (#{align_signal(full,q_mark=false)})
);
"
    end
    
    public

    def self.common_fifo(
        depth:4,
        dsize:8,
        csize:NqString.new('$clog2(DEPTH+1)'),
        clock:"clock",
        rst_n:"rst_n",
        wdata:"wdata",
        wr_en:"wr_en",
        rdata:"rdata",
        rd_en:"rd_en",
        count:"count",
        empty:"empty",
        full:"full",
        belong_to_module:nil
        )
        return_stream = nil
        
        
        
        belong_to_module.DataInf_NC._common_fifo(
            depth:depth,
            dsize:dsize,
            csize:csize,
            clock:clock,
            rst_n:rst_n,
            wdata:wdata,
            wr_en:wr_en,
            rdata:rdata,
            rd_en:rd_en,
            count:count,
            empty:empty,
            full:full)
        return return_stream
    end
        

end

