interface cm_ram_inf #(
    parameter DSIZE = 18,
    parameter RSIZE = 10,
    parameter MSIZE = 1
) ();
logic clka;
logic rsta;
logic ena;
logic clkb;
logic rstb;
logic enb;

logic [16-1:0] addra;
logic [DSIZE-1:0] dia;
logic [MSIZE-1:0] wea;
logic [DSIZE-1:0] doa;
logic [16-1:0] addrb;
logic [DSIZE-1:0] dib;
logic [MSIZE-1:0] web;
logic [DSIZE-1:0] dob;
modport master (
input doa,
input dob,
output addra,
output dia,
output wea,
output dib,
output web,
output ena,
output enb,
output addrb,
output clka,
output rsta,
output clkb,
output rstb
);
modport slaver (
input clka,
input rsta,
input ena,
input clkb,
input rstb,
input enb,
input addra,
input dia,
input wea,
input addrb,
input dib,
input web,
output doa,
output dob
);
modport mirror (
input clka,
input rsta,
input ena,
input clkb,
input rstb,
input enb,
input doa,
input dob,
input addra,
input dia,
input wea,
input addrb,
input dib,
input web
);
modport master_A (
input doa,
output addra,
output dia,
output wea,
output ena,
output clka,
output rsta
);
modport master_B (
input dob,
output addrb,
output dib,
output web,
output enb,
output clkb,
output rstb
);
modport slaver_A (
input clka,
input rsta,
input ena,
input addra,
input dia,
input wea,
output doa
);
modport slaver_B (
input clkb,
input rstb,
input enb,
input addrb,
input dib,
input web,
output dob
);
endinterface:cm_ram_inf
