module mux_2to1(out,in0,in1,addr);
parameter n=1 ;//参数表示输入、输出数据的位数
output[n-1:0] out;
input [n-1:0] in0,in1;
input addr;
reg [n-1:0] out;
always @(in0 or in1 or addr) //敏感信号列表
case(addr)
1'b0: out=in0;
1'b1: out=in1;
default: out=1'bx;
endcase
endmodule