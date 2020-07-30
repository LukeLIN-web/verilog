module display(clk,scan,d0,d1,d2,d3,a,b,c,d,e,f,g,pos);
input clk,scan;
input[3:0] d0,d1,d2,d3;
output a,b,c,d,e,f,g;
//reg a,b,c,d,e,f,g;
output [3:0] pos;
//reg [3:0] pos;  //调用子模块时 输出端口只能用wire类型变量进行映射这是verilog语法规定的  

//优先列好中间变量
wire [1:0] sel;  
wire [3:0] out;
counter_n #(.n(4),.counter_bits(2)) counter_n_inst(  // n=4  counter_bits=2  计数器
    .clk(clk),
    .r(1'b0),
    .en(scan),
    .q(sel),
    .co()
);

decoder_2to4 decoder_2to4_inst(   //计数器 
    .in(sel),
    .out(pos)
);

mux_4to1 mux_4to1_inst(   
    .item0(d0),
    .item1(d1),
    .item2(d2),
    .item3(d3),
    .sel(sel),
    .outdin(out)
);

decoder_7 decoder_7_inst(    //显示译码器
    .in(out),
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .e(e),
    .f(f),
    .g(g)
);
endmodule