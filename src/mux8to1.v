module mux8to1(sel,out,d0,d1,d2,d3,d4,d5,d6,d7);
	//用八选一选择器，可以通过只使用一部分输入达到x选一（x<8）
	parameter bits=8;
	input[bits-1:0] d0,d1,d2,d3,d4,d5,d6,d7;
	input[2:0] sel;
	output[bits-1:0] out; 
	initial
	begin
		{d0,d1,d2,d3,d4,d5,d6,d7}=0;
	end
	wire[bits-1:0] din[7:0]={d7,d6,d5,d4,d3,d2,d1,d0}; 
	assign out=din[sel];
endmodule
