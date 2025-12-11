
`define CheckParamPair(X,Y)\
initial begin\
    Check_Param_Pair(X,Y,`__FILE__,`__LINE__,`"X != Y`");\
end
//---- TAP FLAG -----------------------------------
// `define

`define VIVADO_ENV

`define parameter_string  parameter
`define parameter_longstring(num=63) parameter

// VCS AXI4 comptable macro

// `define VCS_AXI4_CPT(origin_axi4,origin_modport,to_modport,flag)\
// axi_inf #(\
//     .IDSIZE    (origin_axi4.IDSIZE),\
//     .ASIZE     (origin_axi4.ASIZE ),\
//     .LSIZE     (origin_axi4.LSIZE ),\
//     .DSIZE     (origin_axi4.DSIZE ),\
//     .MODE      (origin_axi4.MODE  ),\
//     .ADDR_STEP (origin_axi4.ADDR_STEP),\
//     .FreqM     (origin_axi4.FreqM   )\
// )origin_axi4``_vcs_cpt_``origin_modport``_``to_modport``(\
// /*  input bit */ .axi_aclk      (origin_axi4.axi_aclk      ),\
// /*  input bit */ .axi_aresetn   (origin_axi4.axi_aresetn   )\
// );\
// vcs_axi4_comptable #(\
//     .ORIGIN     (`"origin_modport`"),\
//     .TO         (`"to_modport`")\
// )origin_axi4``_vcs_axi4_comptable_``origin_modport``_``to_modport``_inst(\
// /*  axi_inf   */   .origin      (origin_axi4   ),\
// /*  axi_inf   */   .to          (origin_axi4``_vcs_cpt_``origin_modport``_``to_modport``)\
// );\
// `define origin_axi4``_vcs_cpt``flag origin_axi4``_vcs_cpt_``origin_modport``_``to_modport``

`define VCS_AXI4_CPT(origin_axi4,origin_modport,to_modport,flag)\
`define origin_axi4``_vcs_cpt``flag origin_axi4

// VCS AXI STREAM comptable macro
// `define VCS_AXIS_CPT(origin_axis,origin_modport,to_modport,flag)\
// axi_stream_inf #(\
//     .DSIZE  (origin_axis.DSIZE),\
//     .FreqM  (origin_axis.FreqM),\
//     .KSIZE  (origin_axis.KSIZE),\
//     .CSIZE  (origin_axis.CSIZE)\
// )origin_axis``_vcs_cpt_``origin_modport``_``to_modport``(\
// /*  input bit */ .aclk      (origin_axis.aclk       ),\
// /*  input bit */ .aresetn   (origin_axis.aresetn    ),\
// /*  input bit */ .aclken    (origin_axis.aclken     )\
// );\
// vcs_axis_comptable #(\
//     .ORIGIN     (`"origin_modport`"),\
//     .TO         (`"to_modport`")\
// )origin_axis``_vcs_axis_comptable_``origin_modport``_``to_modport``_inst(\
// /*  axi_inf  */     .origin (origin_axis            ),\
// /*  axi_inf  */     .to     (origin_axis``_vcs_cpt_``origin_modport``_``to_modport``  )\
// );\
// `define origin_axis``_vcs_cpt``flag origin_axis``_vcs_cpt_``origin_modport``_``to_modport``
`define VCS_AXIS_CPT(origin_axis,origin_modport,to_modport,flag)\
`define origin_axis``_vcs_cpt``flag origin_axis

// VCS DATA_C comptable macro
// `define VCS_DATAC_CPT(origin_inf,origin_modport,to_modport,flag)\
// data_inf_c #(\
//     .DSIZE  (origin_inf.DSIZE),\
//     .FreqM  (origin_inf.FreqM)\
// )origin_inf``_vcs_cpt_``origin_modport``_``to_modport``(\
// /*  input bit */ .clock      (origin_inf.clock       ),\
// /*  input bit */ .rst_n      (origin_inf.rst_n       )\
// );\
// vcs_data_c_comptable #(\
//     .ORIGIN     (`"origin_modport`"),\
//     .TO         (`"to_modport`")\
// )origin_inf``_vcs_axis_comptable_``origin_modport``_``to_modport``_inst(\
// /*  data_inf_c  */     .origin (origin_inf            ),\
// /*  data_inf_c  */     .to     (origin_inf``_vcs_cpt_``origin_modport``_``to_modport``  )\
// );\
// `define origin_inf``_vcs_cpt``flag origin_inf``_vcs_cpt_``origin_modport``_``to_modport``
`define VCS_DATAC_CPT(origin_inf,origin_modport,to_modport,flag)\
`define origin_inf``_vcs_cpt``flag origin_inf

// VCS AXI4 comptable macro
// Lock TO
// `define VCS_AXI4_CPT_LT(inf,origin_modport,to_modport,flag)\
// axi_inf #(\
//     .IDSIZE    (inf.IDSIZE),\
//     .ASIZE     (inf.ASIZE ),\
//     .LSIZE     (inf.LSIZE ),\
//     .DSIZE     (inf.DSIZE ),\
//     .MODE      (inf.MODE  ),\
//     .ADDR_STEP (inf.ADDR_STEP),\
//     .FreqM     (inf.FreqM   )\
// )inf``_vcs_cpt_``origin_modport``_``to_modport``(\
// /*  input bit */ .axi_aclk      (inf.axi_aclk      ),\
// /*  input bit */ .axi_aresetn   (inf.axi_aresetn   )\
// );\
// vcs_axi4_comptable #(\
//     .ORIGIN     (`"origin_modport`"),\
//     .TO         (`"to_modport`")\
// )inf``_vcs_axi4_comptable_``origin_modport``_``to_modport``_inst(\
// /*  axi_inf   */   .origin      (inf``_vcs_cpt_``origin_modport``_``to_modport``),\
// /*  axi_inf   */   .to          (inf)\
// );\
// `define inf``_vcs_cpt``flag inf``_vcs_cpt_``origin_modport``_``to_modport``
`define VCS_AXI4_CPT_LT(inf,origin_modport,to_modport,flag)\
`define inf``_vcs_cpt``flag inf

// `define VCS_AXI4_CPT(origin_axi4,origin_modport,to_modport)\
// `define origin_axi4``_vcs_cpt origin_axi4

// VCS AXI STREAM comptable macro
// Lock to
// `define VCS_AXIS_CPT_LT(inf,origin_modport,to_modport,flag)\
// axi_stream_inf #(\
//     .DSIZE  (inf.DSIZE),\
//     .FreqM  (inf.FreqM),\
//     .KSIZE  (inf.KSIZE),\
//     .CSIZE  (inf.CSIZE)\
// )inf``_vcs_cpt_``origin_modport``_``to_modport``(\
// /*  input bit */ .aclk      (inf.aclk       ),\
// /*  input bit */ .aresetn   (inf.aresetn    ),\
// /*  input bit */ .aclken    (inf.aclken     )\
// );\
// vcs_axis_comptable #(\
//     .ORIGIN     (`"origin_modport`"),\
//     .TO         (`"to_modport`")\
// )inf``_vcs_axis_comptable_``origin_modport``_``to_modport``_inst(\
// /*  axi_inf  */     .origin (inf``_vcs_cpt_``origin_modport``_``to_modport``  ),\
// /*  axi_inf  */     .to     (inf  )\
// );\
// `define inf``_vcs_cpt``flag inf``_vcs_cpt_``origin_modport``_``to_modport``
`define VCS_AXIS_CPT_LT(inf,origin_modport,to_modport,flag)\
`define inf``_vcs_cpt``flag inf


// VCS DATA_C comptable macro
// Lock to 
// `define VCS_DATAC_CPT_LT(inf,origin_modport,to_modport,flag)\
// data_inf_c #(\
//     .DSIZE  (inf.DSIZE),\
//     .FreqM  (inf.FreqM)\
// )inf``_vcs_cpt_``origin_modport``_``to_modport``(\
// /*  input bit */ .clock      (inf.clock       ),\
// /*  input bit */ .rst_n      (inf.rst_n       )\
// );\
// vcs_data_c_comptable #(\
//     .ORIGIN     (`"origin_modport`"),\
//     .TO         (`"to_modport`")\
// )inf``_vcs_axis_comptable_``origin_modport``_``to_modport``_inst(\
// /*  data_inf_c  */     .origin (inf``_vcs_cpt_``origin_modport``_``to_modport``  ),\
// /*  data_inf_c  */     .to     (inf  )\
// );\
// `define inf``_vcs_cpt``flag inf``_vcs_cpt_``origin_modport``_``to_modport``
`define VCS_DATAC_CPT_LT(inf,origin_modport,to_modport,flag)\
`define inf``_vcs_cpt``flag inf

// VCS AXI4 comptable macro

// `define VCS_AXI4_ARRAY_CPT(num,origin_axi4,origin_modport,to_modport,flag)\
// axi_inf #(\
//     .IDSIZE    (origin_axi4[0].IDSIZE),\
//     .ASIZE     (origin_axi4[0].ASIZE ),\
//     .LSIZE     (origin_axi4[0].LSIZE ),\
//     .DSIZE     (origin_axi4[0].DSIZE ),\
//     .MODE      (origin_axi4[0].MODE  ),\
//     .ADDR_STEP (origin_axi4[0].ADDR_STEP),\
//     .FreqM     (origin_axi4[0].FreqM   )\
// )origin_axi4``_vcs_cpt_``origin_modport``_``to_modport`` [num-1:0](\
// /*  input bit */ .axi_aclk      (origin_axi4[0].axi_aclk      ),\
// /*  input bit */ .axi_aresetn   (origin_axi4[0].axi_aresetn   )\
// );\
// vcs_axi4_array_comptable #(\
//     .NUM        (num  ),\
//     .ORIGIN     (`"origin_modport`"),\
//     .TO         (`"to_modport`")\
// )origin_axi4``_vcs_axi4_comptable_``origin_modport``_``to_modport``_inst(\
// /*  axi_inf   */   .origin      (origin_axi4   ),\
// /*  axi_inf   */   .to          (origin_axi4``_vcs_cpt_``origin_modport``_``to_modport``)\
// );\
// `define origin_axi4``_vcs_cpt``flag origin_axi4``_vcs_cpt_``origin_modport``_``to_modport``
`define VCS_AXI4_ARRAY_CPT(num,origin_axi4,origin_modport,to_modport,flag)\
`define origin_axi4``_vcs_cpt``flag origin_axi4


// `define VCS_AXI4_ARRAY_CPT_LT(num,inf,origin_modport,to_modport,flag)\
// axi_inf #(\
//     .IDSIZE    (inf[0].IDSIZE),\
//     .ASIZE     (inf[0].ASIZE ),\
//     .LSIZE     (inf[0].LSIZE ),\
//     .DSIZE     (inf[0].DSIZE ),\
//     .MODE      (inf[0].MODE  ),\
//     .ADDR_STEP (inf[0].ADDR_STEP),\
//     .FreqM     (inf[0].FreqM   )\
// )inf``_vcs_cpt_``origin_modport``_``to_modport`` [num-1:0](\
// /*  input bit */ .axi_aclk      (inf[0].axi_aclk      ),\
// /*  input bit */ .axi_aresetn   (inf[0].axi_aresetn   )\
// );\
// vcs_axi4_array_comptable #(\
//     .NUM        (num    ),\
//     .ORIGIN     (`"origin_modport`"),\
//     .TO         (`"to_modport`")\
// )inf``_vcs_axi4_comptable_``origin_modport``_``to_modport``_inst(\
// /*  axi_inf   */   .origin      (inf``_vcs_cpt_``origin_modport``_``to_modport``),\
// /*  axi_inf   */   .to          (inf)\
// );\
// `define inf``_vcs_cpt``flag inf``_vcs_cpt_``origin_modport``_``to_modport``
`define VCS_AXI4_ARRAY_CPT_LT(num,inf,origin_modport,to_modport,flag)\
`define inf``_vcs_cpt``flag inf
