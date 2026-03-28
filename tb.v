`timescale 1ns/1ps

module tb;

reg clk=0;
reg rst;
reg ped_request;

wire [2:0] main_light, side_light;

traffic_light #(.SIM(1)) uut (
    .clk(clk),
    .rst(rst),
    .ped_request(ped_request),
    .main_light(main_light),
    .side_light(side_light)
);

always #5 clk = ~clk;

initial begin
    rst=1; ped_request=0;
    #20 rst=0;

    #100 ped_request=1;
    #20 ped_request=0;

    #200 ped_request=1;
    #20 ped_request=0;

    #100000 $finish;
end
initial begin
    $monitor("Time=%0t slow_clk=%b state=%b counter=%d",
              $time, uut.slow_clk, uut.state, uut.counter);
end
endmodule