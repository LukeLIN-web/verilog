module counter_bcd(q,co,en,r,clk);
parameter qMaxValue =8'h59  ;//计数器最大值,默认60进制
output[7:0]  q;
output co;
  input clk,en,r;
  wire col;
  assign co=(q==qMaxValue)&&en;//特别注意到这里只能够使用组合电路

counter_n #(.n(10),.counter_bits(4)) counter1(.clk(clk),
.en(en),
.r(r||co)
,.q(q[3:0]),.co(co1)  );
//个位

counter_n #(.n(10),.counter_bits(4)) counter2(.clk(clk),
.en(co1),
.r(r||co)
,.q(q[7:4]),.co()  );

endmodule 