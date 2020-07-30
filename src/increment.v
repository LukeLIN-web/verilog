module increment(inPC,inIR108,out1,outIR108);
input[5:0] inPC;
input[2:0] inIR108;
output [5:0]   out1,outIR108;

// 输入 
assign  out1 = inPC+ 1;  
assign  outIR108 = inPC+inIR108;



endmodule