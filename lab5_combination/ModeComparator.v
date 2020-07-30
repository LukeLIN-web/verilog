module ModeComparator(a,b,m,y);
  input [7:0 ] a,b;
  output[7:0] y;  
  input m ;       //// control signal
  wire agb;
  comp #(.n(8))comp_inst (.a(a), .b(b),.agb(agb), .aeb(),.alb());
  wire[7:0] in0,in1 ;
  mux_2to1 #(.n(8)) mux1(.out(y),.in0(a),.in1(b), .addr(m^~agb) ) ; //创建实例mux1 参数�?8 

endmodule 

