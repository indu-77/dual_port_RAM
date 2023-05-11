module ramdual_tb;
reg clk,rst,wren,ren;
reg [3:0]wradd,radd;
reg [7:0]data;
wire [7:0]dout;

ramdual dut(.clk(clk),.rst(rst),.data(data),.wradd(wradd),.radd(radd),.dout(dout),.wren(wren),.ren(ren));

initial
begin
clk=1'b0;
forever #5 clk=~clk;
end

task reset;
begin
@(negedge clk)
rst=1'b1;
@(negedge clk)
rst=1'b0;
end
endtask

task start;
begin
{rst,wren,ren}=3'b100;
{wradd,radd}=8'b0;
data=8'b0;
end
endtask

task write(input w,r,input [3:0]wd,input[7:0]d);
begin
@(negedge clk)
begin
wren=w;
ren=r;
wradd=wd;
data=d;
end
end
endtask

task read(input r,w,input[3:0]rd);
begin
@(negedge clk)
begin
ren=r;
wren=w;
radd=rd;
end
end
endtask

initial
begin
start;
reset;
write(1,0,4'b1010,8'b10101010);
#20;
read(1,0,4'b1010);
end

initial
#200 $finish();

endmodule

