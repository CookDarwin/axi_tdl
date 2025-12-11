class CMRamInf < TdlSpace::TdlBaseInterface

    hdl_name :cm_ram_inf
    modports :master,:slaver,:mirror,:master_A,:master_B,:slaver_A,:slaver_B
    param_map :dsize,'DSIZE',18 ## <tdl_key><hdl_key><default_value>
    param_map :rsize,'RSIZE',10 ## <tdl_key><hdl_key><default_value>
    param_map :msize,'MSIZE',1 ## <tdl_key><hdl_key><default_value>
    # clock_io_map :aclk,:aclk,100 ## <tdl_key><hdl_key><default_freqM>
    # reset_io_map :aresetn,:aresetn
    sdata_maps :clka,:rsta,:ena,:clkb,:rstb,:enb
    pdata_map   :addra,[16]
    pdata_map   :dia,[:dsize]
    pdata_map   :wea,[:msize]
    pdata_map   :doa,[:dsize]

    pdata_map   :addrb,[16]
    pdata_map   :dib,[:dsize]
    pdata_map   :web,[:msize]
    pdata_map   :dob,[:dsize]

    modport_master_input    :doa,:dob
    modport_master_output   :addra,:dia,:wea,:addra,:dib,:web,:ena,:enb,:addrb,:clka,:rsta,:clkb,:rstb

    modport_slaver_input    :clka,:rsta,:ena,:clkb,:rstb,:enb
    modport_slaver_input    :addra,:dia,:wea,:addrb,:dib,:web
    modport_slaver_output   :doa,:dob

    modport_mirror_input :clka,:rsta,:ena,:clkb,:rstb,:enb,:doa,:dob,:addra,:dia,:wea,:addrb,:dib,:web

    modport_master_A_input    :doa
    modport_master_A_output   :addra,:dia,:wea,:addra,:ena,:clka,:rsta

    modport_master_B_input    :dob
    modport_master_B_output   :addrb,:dib,:web,:addrb,:enb,:clkb,:rstb

    modport_slaver_A_input    :clka,:rsta,:ena,:addra,:dia,:wea
    modport_slaver_A_output   :doa

    modport_slaver_B_input    :clkb,:rstb,:enb,:addrb,:dib,:web
    modport_slaver_B_output   :dob

    gen_sv_interface(__dir__)

end