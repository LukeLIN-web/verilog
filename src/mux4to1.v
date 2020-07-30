module mux41(sel,out,d0,d1,d2,d3);
	//可以少一个端口作为三选一选择器
	parameter bits=8;
	input[bits-1:0] d0,d1,d2,d3;
	input[1:0] sel;
	output reg[bits-1:0]  out; 
	
	always@(sel or d0 or d1 or d2 or d3)
	begin
		if(sel==1) out<=d1;
		else if(sel==2) out<=d2;
		else if(sel==3) out<=d3;
		else out<=d0;
	end
endmodule
