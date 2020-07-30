module button_process_unit(clk,reset,ButtonIn,ButtonOut);
input reset,ButtonIn,clk;
output ButtonOut;
wire w1,w2;
//求每按一次按键，按键处理模块输出�?个正脉冲信号，脉冲的宽度为一�? clk 时钟周期
parameter sim=0;        //参数 sim来控制分频器的分频比。sim 默认�? 0

//调用防颤电路子模�? 
debouncer #(.sim(sim)) debouncer_inst(
    .clk(clk), 
    .out(w2),
    .reset(reset),
    .in(w1)
);

//instantiate  of脉冲宽度变换
pulse_width_convert pulse_width_convert_inst(
.clk(clk), 
.out(ButtonOut),
.in(w2)
);

//instantiate  of 同步�?
synch  synch_inst(
 .asynch_in(ButtonIn),
 .clk(clk),
 .synch_out(w1),
 .reset(1'b0)
 );



endmodule
