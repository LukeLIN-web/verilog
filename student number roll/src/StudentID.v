module StudentID(clk,reset,a,b,c,d,e,f,g,dp,pos);
input clk,reset;
output a,b,c,d,e,f,g,dp;
//reg a,b,c,d,e,f,g;
parameter sim=0;
///////////////////////////////////////////////////////////////
//分频计数器实例，sim=0时，分频比n=5000_0000；计数器位数
//counter_bits=26;而sim=1时，分频比n=10；计数器位数counter_bits=4; 

output [3:0] pos;
//reg [3:0] pos;

//优先列好中间变量
wire pulse2Hz;
wire pulse400Hz;
wire [3:0] out;
wire [51:0] id;
//对于含有大分频比的分频器，仿真既困难且没必要。因此，传�?�参�? sim=1，使两个分频器的分频比设�?
//因此，分频器设置 4 �? 16
counter_n #(.n(sim?4:250000),.counter_bits(sim?2:18)) counter_n_inst1(  // n=4  counter_bits=2
    .clk(clk),
    .r(1'b0),
    .en(1'b1),
    .q(),
    .co(pulse400Hz)
);
//作为分频�? q不连�?
counter_n #(.n(sim?16:200),.counter_bits(sim?4:8)) counter_n_inst2(  // n=4  counter_bits=2
    .clk(clk),
    .r(1'b0),
    .en(pulse400Hz),
    .q(),
    .co(pulse2Hz)
);
display display_inst(   //动�?�显示模�?
    .scan(pulse400Hz),
    .clk(clk),
    .d0(id[39:36]),
    .d1(id[43:40]),
    .d2(id[47:44]),
    .d3(id[51:48]),
    .pos(pos),
	.a(a), 
	.b(b), 
	.c(c), 
	.d(d), 
	.e(e), 
	.f(f), 
	.g(g)
);
cyclic_shifter cyclic_shifter_inst(   //循环移位寄存�?
    .ld(reset),
    .en(pulse2Hz),
    .clk(clk),
    .q(id[51:0])
)    ;

endmodule