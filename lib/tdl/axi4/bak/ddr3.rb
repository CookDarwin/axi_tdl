require_relative ".././axi4"
require_relative ".././axi_stream"
require_relative "./axi4_lib"

class Axi4

    def ddr3(   app_addr:"app_addr",app_cmd:"app_cmd",app_en:"app_en",app_wdf_data:"app_wdf_data",app_wdf_end:"app_wdf_end",app_wdf_mask:"app_wdf_mask",
                app_wdf_wren:"app_wdf_wren",app_rd_data:"app_rd_data",app_rd_data_end:"app_rd_data_end",
                app_rd_data_valid:"app_rd_data_valid",app_rdy:"app_rdy",app_wdf_rdy:"app_wdf_rdy",init_calib_complete:"init_calib_complete")

        $_draw = lambda { ddr3_draw(axi4_master:self,    app_addr:app_addr,app_cmd:app_cmd,app_en:app_en,app_wdf_data:app_wdf_data,app_wdf_end:app_wdf_end,app_wdf_mask:app_wdf_mask,init_calib_complete:init_calib_complete,
                                        app_wdf_wren:app_wdf_wren,app_rd_data:app_rd_data,app_rd_data_end:app_rd_data_end,app_rd_data_valid:app_rd_data_valid,app_rdy:app_rdy,app_wdf_rdy:app_wdf_rdy) }
        @correlation_proc +=$_draw.call
        return self
    end

    def ddr3_draw(axi4_master:self,app_addr:nil,app_cmd:nil,app_en:nil,app_wdf_data:nil,app_wdf_end:nil,app_wdf_mask:nil,app_wdf_wren:nil,app_rd_data:nil,app_rd_data_end:nil,app_rd_data_valid:nil,app_rdy:nil,app_wdf_rdy:nil,init_calib_complete:nil)
        large_name_len(axi4_master,app_addr,app_cmd,app_en,app_wdf_data,app_wdf_end,app_wdf_mask,app_wdf_wren,app_rd_data,app_rd_data_end,app_rd_data_valid,app_rdy,app_wdf_rdy,init_calib_complete)
"\naxi4_to_native_for_ddr_ip_verb #(
    .ADDR_WIDTH         (#{signal}.ASIZE),
    .DATA_WIDTH         (#{signal}.DSIZE)
)axi4_to_native_for_ddr_ip_verb_inst(
/*  axi_inf.slaver                 */ .axi_inf              (#{align_signal(axi4_master          )}),
/*  output logic[ADDR_WIDTH-1:0]   */ .app_addr             (#{align_signal(app_addr             ,false)}),
/*  output logic[2:0]              */ .app_cmd              (#{align_signal(app_cmd              ,false)}),
/*  output logic                   */ .app_en               (#{align_signal(app_en               ,false)}),
/*  output logic[DATA_WIDTH-1:0]   */ .app_wdf_data         (#{align_signal(app_wdf_data         ,false)}),
/*  output logic                   */ .app_wdf_end          (#{align_signal(app_wdf_end          ,false)}),
/*  output logic[DATA_WIDTH/8-1:0] */ .app_wdf_mask         (#{align_signal(app_wdf_mask         ,false)}),
/*  output logic                   */ .app_wdf_wren         (#{align_signal(app_wdf_wren         ,false)}),
/*  input  [DATA_WIDTH-1:0]        */ .app_rd_data          (#{align_signal(app_rd_data          ,false)}),
/*  input                          */ .app_rd_data_end      (#{align_signal(app_rd_data_end      ,false)}),
/*  input                          */ .app_rd_data_valid    (#{align_signal(app_rd_data_valid    ,false)}),
/*  input                          */ .app_rdy              (#{align_signal(app_rdy              ,false)}),
/*  input                          */ .app_wdf_rdy          (#{align_signal(app_wdf_rdy          ,false)}),
/*  input                          */ .init_calib_complete  (#{align_signal(init_calib_complete  ,false)})
);\n"
    end

end
