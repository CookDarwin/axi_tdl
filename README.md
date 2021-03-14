# AxiTdl
[![Gem Version](https://badge.fury.io/rb/axi_tdl.svg)](https://badge.fury.io/rb/axi_tdl)
[![Build Status](https://travis-ci.com/CookDarwin/axi_tdl.svg?branch=main)](https://travis-ci.com/CookDarwin/axi_tdl)

## Axi
&emsp;&emsp;axi是一个 axi4 拓展库，它使用的是删减版的AXI4协议，使用systemverilog开发，除此外我还拓展了AXI4的一些信号。

&emsp;&emsp;axi hdl 所在路径可以如下Ruby 脚本获取
```ruby
require 'axi_tdl'
AxiTdl::AXI_PATH
```
## 其他
&emsp;&emsp;此库还包含一个简单的接口定义, 接口信号只有 `valid`, `ready`, 和 `data`. 对于一些轻量设计很有帮助。

## tdl 是什么？
&emsp;&emsp;tdl 是一种硬件构造语言, 和chisel类似, 但是更加有趣, 他是一种基于Ruby的DSL. 最终它会编译输出systemverilog。 tdl也是基于axi库做的设计。这两部分都包含这此gem包中。

## tdl 能做什么？
&emsp;&emsp;使用tdl做设计开发, 语法类似systemverilog，这样更亲切。不止于此, tdl加入了大量的验证语法。tdl创建的初衷就是为了快速构建`逻辑系统`, 这就是tdl和其他硬件构造语言最大的区别。

## 安装

 Gemfile中添加:

```ruby
gem 'axi_tdl'
```

然后执行:

    $ bundle

或则通过gem命令安装:

    $ gem install axi_tdl

## 代码示例

### 1. 定义模块 
在当前tdl所在的路径创建一个systemverilog模块文件，模块名为 `test_module`.
```ruby 
TdlBuild.test_module(__dir__) do
## Other code
end
```
输出的systemverilog 文件如下：
```systemverilog
`timescale 1ns/1ps
module test_module(
);
endmodule
```
### 2. 端口
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

## 3. 接口
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

## 6. 合并 logic
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


