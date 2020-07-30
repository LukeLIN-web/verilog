module ec2top(Enter,Clock,Reset,Halt,Output,Input);
  input[15:0] Input;
 input Enter,Clock,Reset; 
output[15:0] Output; 

output Halt; 
 	 
wire[7:0]IR158; 
wire PCload,Meminst,MemWr,RegWr,Aload, IRload,JMPmux,Sub,Aeq0,Apos,out;
wire[2:0] Asel0,Asel1;  
 
DP dp1( 

.Input(Input), .Clock(Clock), 
.Reset(Reset), 
.Output(Output), 
.IRload(IRload), 
.JMPmux(JMPmux), 
.PCload(PCload), 
.Meminst(Meminst), 
.MemWr(MemWr), 
.RegWr(RegWr),  //如果不连的话会自动省略
.Asel0(Asel0), 
.Asel1(Asel1),
.Aload(Aload), 
.IR158(IR158), 
.Aeq0(Aeq0), 
.Apos(Apos),
.out(out), 
.Sub(Sub)); 
 
CU cu1( 
.Enter(Enter), 
.Clock(Clock), 
.Reset(Reset), 
.Halt(Halt), 
.IRload(IRload), 
.JMPmux(JMPmux), 
.PCload(PCload), 
.Meminst(Meminst), 
.MemWr(MemWr), 
.RegWr(RegWr),
.Asel0(Asel0), 
.Asel1(Asel1),
.Aload(Aload), 
.IR158(IR158), 
.Aeq0(Aeq0), 
.Apos(Apos), 
.out(out), 
.Sub(Sub)); 
 
endmodule 
