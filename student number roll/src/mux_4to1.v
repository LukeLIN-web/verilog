module mux_4to1(item0,item1,item2,item3,sel,outdin);
input[3:0] item0,item1,item2,item3;
input [1:0]sel;
output [3:0] outdin;
reg [3:0] outdin;
always@(*)
  begin
   case(sel)
    0: outdin=item0;
    1: outdin=item1;
    2: outdin=item2;
    3: outdin=item3;
   endcase
  end
endmodule

