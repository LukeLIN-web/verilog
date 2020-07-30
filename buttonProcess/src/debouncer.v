module debouncer(clk,reset,in,out);

parameter sim=0;//参数 sim来控制分频器的分频比。sim 默认�? 0
//�? sim=1 （仿真）时，设置分频比为 32；�?�当 sim=0（综合�?�实例）时，设置分频比为 100000

wire clk,in,reset,timer_clr,timer_done;
wire out;
output out;
input clk,in,reset;

//调用分频器时，当 sim=1 （仿真）时，设置分频比为 32
counter_n #(.n(sim?32:100000),.counter_bits(sim?5:17)) counter_n_inst(
		.clk(clk),
        .r(), 
		.en(1'b1), 
		.co(pulse1KHz),
        .q()
);


timer #(.n(10)) timer_inst(
		.clk(clk),
        .en(pulse1KHz), 
		.timer_clr(timer_clr), 
		.timer_done(timer_done)
);  //1ms  *10  =10ms


controler  controler_inst(
.clk(clk),
.reset(reset),
.in(in),.out(out),
.timer_clr(timer_clr),
.timer_done(timer_done));



endmodule