module timing(clk,r,en,q0,qs,qm);
input en,r,clk;
output [3:0]q0,qm;
output [7:0]qs;
wire w1,w2;

counter_n #(.n(10),.counter_bits(4)) counter_n_inst1(.clk(clk),
.en(en),
.r(r)
,.q(q0),.co(w1)  );


counter_bcd counter_bcd_inst(.clk(clk),
.en(w1),
.r(r)
,.q(qs),.co(w2)  );


counter_n #(.n(10),.counter_bits(4)) counter_n_inst2(.clk(clk),
.en(w2),
.r(r)
,.q(qm),.co()  );

endmodule 