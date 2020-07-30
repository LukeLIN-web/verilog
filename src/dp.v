module DP (IRload,JMPmux,PCload,Meminst,Reset,Clock,IR158,MemWr,Input,sel01,Aout,out,
RegWr,Jsel,Asel1,Asel0,Aload,Output,Apos,Aeq0,Sub ); 
 
input IRload,JMPmux,PCload,Meminst,Reset,Clock,MemWr,Aload,Sub,RegWr,out;
input[1:0]Jsel;
input[15:0] Input; 
input sel01; 
input[2:0] Asel0,Asel1; 
output [8:0] IR158; 
output[7:0] Output; 
output Aeq0,Apos; 
output reg[7:0] Aout=0;	//输出

wire[7:0] w7,w8,w1,IR70,A; 
wire [2:0] IR108;
wire [5:0]w2,w3,w4,w5,w13;  
wire[15:0] w11,w12,w10,w9;
wire[4:0] w6; 
 assign IR108=IR158[2:0];
//实例化下列子模块
ir ir1(.D(w1),.load(IRload),.Clear(Reset),.clk(Clock),.IR158(IR158),.IR70(IR70));
//PC部分
mux41  #(.bits(6)) mux1 (.sel(Jsel),.out(w5),.d0(w3),.d1(w13),.d2(w2),.d3());//选择传入PC的地址,00是自增1,01是相对寻址,10是绝对寻址
pc pc1(.D50(w5),.load(PCload),.Clear(Reset),.clk(Clock),.pc_addr(w4));
increment increment1(.inPC(w4),.inIR108(w7),.out1(w3),.outIR108(w13));
mux_2to1 #(.n(6)) mux2(.in0(w4),.in1(w2),.addr(Meminst),.out(w6));  //Meminst=0 w4从PC, =1是从IR六位绝对寻址. 
mux_2to1 #(.n(16)) mux3(.in0(w11),.in1(w12),.addr(sel01),.out(w10));

//内存部分
mem1  ram1(.data(w8),.addr(w6),.qout(w1),.we(MemWr),.clk(Clock),.reset(Reset));  //w6传入地址
memR  ram2(.data(w8),.addr(IR108),.qout(w9),.we(RegWr),.clk(Clock),.reset(Reset));//IR10-8传入地址

//累加器部分
a a1(.load(Aload),.Clear(Reset),.clk(Clock),.D(w10),.Output(w8),.Apos(Apos),.Aeq0(Aeq0)); 
ARITH ARITH1(.Ain(w8),.Rin(w9),.Min(w1),.inputt(Input),.out1(w11),.out2(w12),.Asel0(Asel0),.Asel1(Asel1),.imm(IR70)); 
//output part
always@(A or out)
begin
		if(out)  Aout=A;
		else	Aout=Aout;
end

endmodule