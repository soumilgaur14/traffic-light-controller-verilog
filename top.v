module top(
    input clk,
    input [3:0] btn,
    output [15:0] led
);

wire [2:0] main_light;
wire [2:0] side_light;

traffic_light #(.SIM(0)) uut (
    .clk(clk),
    .rst(btn[0]),
    .ped_request(btn[1]),
    .main_light(main_light),
    .side_light(side_light)
);

// LED mapping
assign led[0] = main_light[0];
assign led[1] = main_light[1];
assign led[2] = main_light[2];

assign led[3] = side_light[0];
assign led[4] = side_light[1];
assign led[5] = side_light[2];

assign led[15:6] = 0;

endmodule