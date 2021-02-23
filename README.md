# Axi
&emsp;&emsp;It is a wonderful library of axi4, but it is not full axi4, It is designed by systemverilog. I compact axi4 and add something to it.
&emsp;&emsp;axi hdl path
```ruby
require 'axi_tdl'
AxiTdl::AXI_PATH
```
# Other
&emsp;&emsp;It contain a simple interface that only define three signals, `valid`, `ready`, and `data`. I think it is useful for design. 

## What is tdl?
&emsp;&emsp;tdl is a hardware Construction language, it like chisel, but more intresting. It is a DSL and base on ruby. Finally, it convert to systemverilog. And it depend on the axi library of my other github respo.

## What tdl can do?
&emsp;&emsp;When you write RTL code by tdl, it look like systemverilog. And not only that, you can verify design by tdl. Even more, you can construct `Logic System`, I think it is main difference between tdl and other hardware Construction languages. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'axi_tdl'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install axi_tdl

## Code Example

### 1. define module 
It will create a module of systemverilog that name is `test_module` in current dir.
```ruby 
TdlBuild.test_module(__dir__) do
## Other code
end
```
the sv file look like this
```systemverilog
`timescale 1ns/1ps
module test_module(
);
endmodule
```
### 2. ports
```ruby 
TdlBuild.test_module(__dir__) do 
    input.clock         - 'clock'
    input.reset('low')  - 'rst_n'
    input               - 'd0'
    input[32]           - 'd32'
    output[16]          - 'o16'
    output.logic[8]     - 'o8'
    output.logic        - 'o1'
end
```
```systemverilog
module test_module (
    input             clock,
    input             rst_n,
    input             d0,
    input [31:0]      d32,
    output [15:0]     o16,
    output logic[7:0] o8,
    output logic      o1
);
endmodule
```

## 3. interface
```ruby 
TdlBuild.test_interface(__dir__) do 

    input.clock         - 'clock'
    input.reset('low')  - 'rst_n'
    input               - 'd0'
    input[32]           - 'd32'
    output[16]          - 'o16'
    output.logic[8]     - 'o8'
    output.logic        - 'o1'

    port.axis.slaver    - 'axis_in'
    port.axis.master    - 'axis_out'
    port.axis.mirror    - 'axis_mirror'

    port.data_c.master  - 'intf_data_inf'
    port.axi4.slaver    - 'taxi4_inf' 

end 
```
```systemverilog
module test_module (
    input                   clock,
    input                   rst_n,
    input                   d0,
    input [31:0]            d32,
    output [15:0]           o16,
    output logic[7:0]       o8,
    output logic            o1,
    axi_stream_inf.slaver   axis_in,
    axi_stream_inf.master   axis_out,
    axi_stream_inf.mirror   axis_mirror,
    data_inf_c.master       intf_data_inf,
    axi_inf.slaver          taxi4_inf
);
end
```
## 4. always assign 
```ruby 
TdlBuild.test_module(__dir__) do 
    input.clock         - 'clock'
    input.reset('low')  - 'rst_n'
    input               - 'd0'
    input[32]           - 'd32'
    output[16]          - 'o16'
    output.logic[8]     - 'o8'
    output.logic        - 'o1'

    port.axis.slaver    - 'axis_in'
    port.axis.master    - 'axis_out'
    port.axis.mirror    - 'axis_mirror'

    port.data_c.master  - 'intf_data_inf'
    port.axi4.slaver    - 'taxi4_inf'


    always_ff(posedge: clock,negedge: rst_n) do 
        IF ~rst_n do 
            o16 <= 0.A 
        end
        ELSE do 
            IF d0 do 
                o16 <= 1.A 
            end 
            ELSE do 
                o16 <= o16 + 1.b1 
            end
        end
    end

    always_comb do 
        o8  <= d32[7,0]
    end

    Assign do 
        o1  <= 1.b0
    end
end
```
```systemverilog
module test_module (
    input                   clock,
    input                   rst_n,
    input                   d0,
    input [31:0]            d32,
    output [15:0]           o16,
    output logic[7:0]       o8,
    output logic            o1,
    axi_stream_inf.slaver   axis_in,
    axi_stream_inf.master   axis_out,
    axi_stream_inf.mirror   axis_mirror,
    data_inf_c.master       intf_data_inf,
    axi_inf.slaver          taxi4_inf
);

always_ff@(posedge clock,negedge rst_n) begin 
    if(~rst_n)begin
         o16 <= '0;
    end
    else begin
        if(d0)begin
             o16 <= '1;
        end
        else begin
             o16 <= ( o16+1'b1);
        end
    end
end

always_comb begin 
     o8 = d32[7:0];
end

assign  o1 = 1'b0;

endmodule
```
## 5. generate
```ruby
TdlBuild.test_generate(__dir__) do 
    parameter.NUM       8
    input[8]            - 'ain'
    output[8]           - 'bout'

    input[param.NUM,6]  - 'cin'
    output[6,param.NUM] - 'dout'

    input[param.NUM]    - 'ein'
    output[param.NUM]   - 'fout'

    generate(8) do |kk|
        Assign do 
            bout[kk]    <= ain[7-kk]
        end
    end

    generate(param.NUM) do |cc|
        IF cc < 4 do
            Assign do  
                dout[cc]    <= cin[cc]
            end
        end
        ELSE do 
            Assign do 
                dout[cc]    <= cin[cc] + cc 
            end
        end
    end

    generate(param.NUM,6) do |ii,gg|
        Assign do 
            fout[ii][gg]    <= ein[gg][ii]
        end
    end
end
```
```systemverilog
module test_generate #(
    parameter  NUM = 8
)(
    input [7:0]       ain,
    output [7:0]      bout,
    input [5:0]       cin  [NUM-1:0],
    output [ NUM-1:0] dout [6-1:0],
    input [ NUM-1:0]  ein,
    output [ NUM-1:0] fout
);

generate
for(genvar KK0=0;KK0 < 8;KK0++)begin
    assign  bout[ KK0] = ain[ 7-( KK0)];
end
endgenerate

generate
for(genvar KK0=0;KK0 < NUM;KK0++)begin

    if( KK0<4)begin
        assign  dout[ KK0] = cin[ KK0];
    end 
    else begin
        assign  dout[ KK0] = ( cin[ KK0]+( KK0));
    end
end
endgenerate

generate
for(genvar KK0=0;KK0 < NUM;KK0++)begin
    for(genvar KK1=0;KK1 < 6;KK1++)begin
        assign  fout[ KK0][ KK1] = ein[ KK1][ KK0];
    end
end
endgenerate

endmodule
```

## 6. combin logic
```ruby
TdlBuild.test_logic_combin(__dir__) do 
    logic[7]    - 'a0'
    logic[5]    - 'a1'
    logic[9]    - 'a2'
    logic[9+5+7]    - 'ca'

    logic[2,8]  - 'b0'
    logic[16]   - 'b1'
    logic[32]   - 'cb'

    logic[1,8]  - 'c0'
    logic[3,8]  - 'c1'
    logic[2,16] - 'cc'

    Assign do 
        ca <= logic_bind_(a0, a1, a2)
        cb <= self.>>(b1, b0)
        cc <= self.<<(c0, c1)
    end
end
```
```systemverilog
module test_logic_combin ();

logic [7-1:0]  a0 ;
logic [5-1:0]  a1 ;
logic [9-1:0]  a2 ;
logic [21-1:0]  ca ;
logic [8-1:0]  b0[2-1:0] ;
logic [16-1:0]  b1 ;
logic [32-1:0]  cb ;
logic [8-1:0]  c0[1-1:0] ;
logic [8-1:0]  c1[3-1:0] ;
logic [16-1:0]  cc[2-1:0] ;

assign  ca = {a0,a1,a2};
assign  cb = {>>{b1,b0}};
assign  cc = {<<{c0,c1}};

endmodule
```


