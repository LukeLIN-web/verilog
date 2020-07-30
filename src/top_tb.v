`timescale 1ns/100ps

module EC2_tb_v;
	parameter DELY=10;
	//输入
	reg clk;
	reg reset;
	reg[15:0] Ain;
	
	//输出
	wire[15:0] Aout;
	wire halt;
	
	//实例化顶层模�?
	ec2top uut(.Clock(clk), 
	.Reset(reset), 
	.Input(Ain), 
	.Output(Aout), 
	.Halt(halt));
	
	//时钟
	always #(DELY/2) clk=~clk;
	initial begin
		clk=0;reset=0;Ain=31;
		#(DELY/2+1) reset=1;
		#(DELY*2) reset=0;
		#(DELY*150) $stop;
	end
endmodule