module stopwatch(clk, ButtonIn, a,b,c,d,e,f,g,dp ,pos,reset);
input ButtonIn,clk,reset;
output a,b,c,d,e,f,g;
wire a,b,c,d,e,f,g;
output [3:0] pos;
output dp;
wire [3:0] pos;
wire dp;
wire [7:0] qs ;
wire [3:0] q0,qm;
wire ButtonOut,clr,count ;
parameter sim=0;
reg led0,led1;  
///////////////////////////////////////////////////////////////
//分频计数器实例，sim=0时，分频比i �?250000 ii �?40；计数器位数
//counter_bits=18;而sim=1时，分频比i �?2 ii �?10；计数器位数counter_bits=4; 
//对于含有大分频比的分频器，仿真既困难且没必要。因此，传参�? sim=1，使两个分频器的分频比设�?
//分频模块 
assign  dp = pos[1] ;
counter_n #(.n(sim?2:250000),.counter_bits(sim?2:18)) counter_n_inst1(  // n=4  counter_bits=2
    .clk(clk),
    .r(1'b0),
    .en(1'b1),
    .q(),
    .co(pulse400Hz)
);
//作为分频
counter_n #(.n(sim?10:40),.counter_bits(sim?4:6)) counter_n_inst2(  
    .clk(clk),
    .r(1'b0),
    .en(pulse400Hz),
    .q(),
    .co(pulse10Hz)
);

button_process_unit #(.sim(sim))  button_process_unit_inst(
  .clk(clk),
  .reset(reset),
  .ButtonIn(ButtonIn),
  .ButtonOut(ButtonOut)
   );

control control_inst(
		.clk(clk), 
		.reset(reset),
		.in(ButtonOut), 	
		.clr(clr), 
		.count(count) );

 timing  timing_inst (
		.clk(clk),
        .r(clr), 
		.en(count&&pulse10Hz), 
        .q0(q0),
		.qs(qs),
		.qm(qm));
		

display  display_inst(
		.clk(clk), 
		.scan(pulse400Hz),
		.d0(q0),
		.d1(qs[3:0]),
		.d2(qs[7:4]),
		.d3(qm),
		.a(a), 
		.b(b), 
		.c(c), 
		.d(d), 
		.e(e), 
		.f(f), 
		.g(g), 
		.pos(pos));
//附加测试电路代码
 always@( posedge clk)
 if(pulse10Hz) led0 =~led0;
  always@( posedge clk)
 if(ButtonOut) led1 =~led1;

assign led2 =count ;
assign led3  =clr;
 

endmodule