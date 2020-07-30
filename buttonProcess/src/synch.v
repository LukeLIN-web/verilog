module synch(asynch_in,clk,synch_out,reset);
input clk;
input asynch_in;
input reset;
output synch_out;
reg q1,synch_out;
//wire rst;
//assign rst = synch_out||reset;

//第一级锁存器
always @(posedge clk)
	begin 
		if(reset)
			q1 <= 0;
		else
			q1 <= asynch_in;
	end

//第er级锁存器
always@(posedge clk )
	begin
		if(reset)
			synch_out <= 0;
		else
			synch_out <= q1;
	end
endmodule