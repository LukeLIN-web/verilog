module comp(a,b,agb,aeb,alb);
parameter n=1;//参数表示比较器的位数 
input [n-1:0]  a, b;
output agb;// a 大于 b
output  aeb;// a 等于 b 
output  alb;// a 小于 b
reg  alb, agb,aeb;
	
always @(a or b)
		
begin	agb = 0; aeb =0 ; alb =0; 
		if(a==b)
         aeb=1;
	    else if(a>b)
	    agb=1;
		else
		    alb=1;
end

endmodule 