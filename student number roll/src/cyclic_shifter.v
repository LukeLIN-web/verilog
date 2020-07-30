module cyclic_shifter(ld,en,clk,q);
  parameter storage_bits=52;
  parameter shift_bits=4;
  //循环移位寄存
  input ld,en,clk;
  output[storage_bits-1:0] q;
  reg[storage_bits-1:0] q;
 always @(posedge clk)
    begin
      if(ld) q=52'haaa3180103721;
      else if(en)
         q={q[47:0],q[51:48]};//{}用作位拼�?,�?以begin来代�?
		else q= q;
	end
endmodule
