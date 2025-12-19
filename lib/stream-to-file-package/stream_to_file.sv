/****************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
--Module Name:  stream_to_file.sv
--Project Name: stream-to-file-package
--Data modified: 2015-09-28 11:02:56 +0800
--author:Young-吴明
--E-mail: wmy367@Gmail.com
****************************************/
`timescale 1ns/1ps
module stream_to_file #(
	parameter string			FILE_PATH	= "",
	parameter string			HEAD_MARK	= "",
	parameter string			DATA_SPLIT	= "     ",
	parameter TRIGGER_TOTAL		= 1000
)(
	input		enable			,
	input		posedge_trigger	,
	input		negedge_trigger ,
	input		signal_trigger  ,
	input longint	data []
);

import StreamFilePkg::*;

StreamFileClass streamfile = new(FILE_PATH,HEAD_MARK);

int         cnt;

initial begin
    $timeformat(-9,3,"ns",8);
	streamfile.head_mark	= HEAD_MARK;
    cnt = 0;
    #(11ns);
	$display("AT TIME: %t %t--->>SAVING TO FILE(%s) .....",$time,$realtime,FILE_PATH);
	// repeat(TRIGGER_TOTAL)begin
	// 	wait(enable);
	// 	@(posedge posedge_trigger,negedge negedge_trigger,signal_trigger);
	// 	streamfile.puts(data,DATA_SPLIT);
	// end
	// streamfile.close_file();
	// $display("AT TIME: %t --->>SAVING TO FILE(%s) DONE!",$time,FILE_PATH);
end

always@(posedge posedge_trigger)
    if(posedge_trigger == 1'b1)begin
        wr_file_chk();
    end

always@(negedge negedge_trigger)
    if(negedge_trigger == 1'b0)begin
        wr_file_chk();
    end

always@(signal_trigger)
    if(signal_trigger == 1'b0 || signal_trigger == 1'b1)begin
        wr_file_chk();
    end

task automatic wr_file_chk();
    cnt += 1;
    if(cnt == TRIGGER_TOTAL)begin
        streamfile.close_file();
        $display("AT TIME: %t --->>SAVING TO FILE(%s) DONE!",$time,FILE_PATH);
    end else begin
        streamfile.puts(data,DATA_SPLIT);
    end
endtask:wr_file_chk

endmodule
