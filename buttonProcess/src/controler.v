module controler(clk,reset,in,out,timer_clr,timer_done);
input clk,in,reset,timer_done;
output timer_clr,out;
localparam s0           = 0          ;
localparam s1           = 1           ;
localparam s2           = 2          ;
localparam s3           = 3        ;
reg[1:0] pre_state ,nex_state ; 
reg timer_clr,out;
//时序电路,D型寄存器  
always@(posedge clk )
	begin
		if (reset==1'b1) pre_state<=s0;
		else pre_state<=nex_state;
	end
//   组合电路 ,下一状�?�和输出电路

always@(*)    //always模块中的任何�?个输入信号或电平发生变化�?,该语句下方的模块将被执行�?
	begin
	
		out= 0;
		case (pre_state)
			s0:begin if(in==1'b1) nex_state<=s1; 
					else nex_state<=s0; 
					 begin timer_clr=1; out = 0; end
				end
			s1:begin timer_clr=0;   out =1;
			         if(timer_done==1'b1) nex_state<=s2;
					else  begin nex_state<=s1; end
				end	
			s2:begin timer_clr =1;out =1 ; 
			         if(in==1'b1) begin  nex_state<=s2; end
					else nex_state<=s3 ;	
				end
			s3:begin	out =1;	timer_clr=0;
			      if(timer_done==1'b1 )  nex_state<=s0;
					else  begin  nex_state<=s3;	end
				end 
			default:begin nex_state<=s0;out =0;timer_clr=0; end
		endcase
end




endmodule