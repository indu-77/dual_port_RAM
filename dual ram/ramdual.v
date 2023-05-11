module ramdual(clk,rst,wren,ren,wradd,radd,data,dout);
input clk,rst,wren,ren;
parameter width=8;
parameter depth=16;
parameter addr=4;

input [addr-1:0]wradd,radd;
input [width-1:0]data;
output reg [width-1:0]dout;

reg [width-1:0] mem [0:depth-1];

integer i;

always @(posedge clk)
begin
if(rst)
begin
for(i=0;i<depth;i=i+1)
begin
mem[i]=0;
end
end
else if(wren==1&&ren==0)
begin
mem[wradd]<=data;
end
else if(ren==1&&wren==0)
begin
dout<=mem[radd];
end
else
dout<=8'b0;
end

endmodule