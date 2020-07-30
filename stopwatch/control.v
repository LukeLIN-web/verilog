module control(clk,reset,clr,count,in);
//秒表电路中的 控制器,不是按键处理中的控制器.
input clk,in,reset;
output clr,count;
localparam s0           = 0          ;  //RESET
localparam s1           = 1           ; //TIMING
localparam s2           = 2          ; //STOP
reg[1:0] pre_state ,nex_state ; 
reg count,clr;     //控制器clear变量, always 里就是reg型,  always外是wire型.

//时序电路,D型寄存器  
always@(posedge clk or posedge reset)
	begin
		if (reset==1'b1) pre_state<=s0;
		else pre_state<=nex_state;
	end
//   组合电路 ,下一状态和输出电路

always@(*)    //always模块中的任何一个输入信号或电平发生变化时,该语句下方的模块将被执行。
	begin
		nex_state<=2'bxx;
		count= 0;
		case (pre_state)
			s0:begin clr=1; count = 0;  
					if(in==1'b1) begin  nex_state<=s1; end
					else nex_state<=s0;   
				end
			s1:begin clr=0; count = 1;
					if(in==1'b1)  begin  nex_state<=s2; end
					else  begin nex_state<=s1;  end
				end	
			s2:begin clr=0; count = 0; 
					if(in==1'b1) begin  nex_state<=s0;   end
					else nex_state<=s2 ;	
				end
			default:begin nex_state<=s0;clr =1;count =0;end
		endcase
end

endmodule
