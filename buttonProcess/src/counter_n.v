module counter_n(clk,en,r,q,co);//为一个计数器
  parameter n=2;  //二分频
  //同步计数器/分频器为 Mealy 型电路，进位输出 co 为组合输出，一般用 assign 语句赋值，不能放在 always @(posedge clk) 内赋值。 
  //（2）co 的宽度为一个 clk 时钟周期，且进位输出 co 与 en 有关。因此，使用时应保证输入脉冲 en 宽度为一个 clk 时钟周期。 
  //（3）计数器/分频器可理解为对输入脉冲 en 进行计数，如若对 clk 进行计数，只需将en 接高电平。
  parameter counter_bits=1;

  input clk,en,r;
  output co;
  output[counter_bits-1:0] q;
  reg[counter_bits-1:0] q=0;
  assign co=(q==(n-1))&&en;//特别注意到这里只能够使用组合电路

always@(posedge clk)
 begin 
      if(r) q=0;
      else if(en)
           begin 
               if(q==(n-1)) q=0;
               else q=q+1;
           end
  end
endmodule
