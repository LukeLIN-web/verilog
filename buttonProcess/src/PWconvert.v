module pulse_width_convert(clk,in,out);
input clk,in;
output out;
reg q1;
wire out ;  //// module 不用reg out

//第一级锁存器
always @(posedge clk)
begin 
		q1 <= in;
end

assign out = in&&(~q1);



endmodule
