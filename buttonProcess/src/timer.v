module timer(clk,en,timer_clr,timer_done);
parameter n=10;
input clk,en,timer_clr;
output timer_done;
 //// module 不用reg out
reg[3:0] q=0;
assign timer_done=(q==(n-1))&&en;
  
//第一级锁存器
  always@(posedge clk)
  begin 
      if(timer_clr)q = 0; 
      else if(en)
           begin 
               if(q==(n-1)) q=0;
               else q=q+1;
           end
  end
endmodule
