module traffic_light #(
    parameter SIM = 1
)(
    input clk,
    input rst,
    input ped_request,
    output reg [2:0] main_light,
    output reg [2:0] side_light
);

// STATES
parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010,
          S3 = 3'b011, S4 = 3'b100;

// LIGHTS
parameter RED=3'b100, YELLOW=3'b010, GREEN=3'b001;

reg [2:0] state, next_state;
reg [3:0] counter;
reg ped_pending;

// CLOCK DIVIDER
reg [25:0] clk_div;
wire slow_clk;

always @(posedge clk or posedge rst) begin
    if (rst) clk_div <= 0;
    else clk_div <= clk_div + 1;
end

assign slow_clk = (SIM) ? clk : clk_div[25];

// PEDESTRIAN LATCH
always @(posedge slow_clk or posedge rst) begin
    if (rst) ped_pending <= 0;
    else if (ped_request) ped_pending <= 1;
    else if (state == S4) ped_pending <= 0;
end

// FSM
always @(posedge slow_clk or posedge rst) begin
    if (rst) begin
        state <= S0;
        counter <= 0;
    end else begin
        state <= next_state;
        counter <= (state != next_state) ? 0 : counter + 1;
    end
end

// NEXT STATE
always @(*) begin
    case(state)
        S0: next_state = (counter==10)?S1:S0;
        S1: next_state = (counter==3)? (ped_pending?S4:S2):S1;
        S2: next_state = (counter==10)?S3:S2;
        S3: next_state = (counter==3)? (ped_pending?S4:S0):S3;
        S4: next_state = (counter==5)?S0:S4;
        default: next_state = S0;
    endcase
end

// OUTPUT
always @(*) begin
    case(state)
        S0: begin main_light=GREEN; side_light=RED; end
        S1: begin main_light=YELLOW; side_light=RED; end
        S2: begin main_light=RED; side_light=GREEN; end
        S3: begin main_light=RED; side_light=YELLOW; end
        S4: begin main_light=RED; side_light=RED; end
        default: begin main_light=RED; side_light=RED; end
    endcase
end

endmodule