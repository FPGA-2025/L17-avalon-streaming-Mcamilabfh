module avalon (
    input wire clk,
    input wire resetn,
    input wire ready,

    output reg valid,
    output reg [7:0] data
);

reg [2:0] state, next_state;

localparam ESPERA_4 = 3'd0;
localparam ENVIO_4  = 3'd1;
localparam ESPERA_5 = 3'd2;
localparam ENVIO_5  = 3'd3;
localparam ESPERA_6 = 3'd4;
localparam ENVIO_6  = 3'd5;
localparam DONE     = 3'd6;

always @(posedge clk or negedge resetn) begin
    if (!resetn) 
        state <= ESPERA_4;
    else
    state <= next_state;    
end

always @(*) begin
    next_state = state; //default

    if (state == ESPERA_4)
        next_state = (ready) ? ENVIO_4 : ESPERA_4;
    else if (state == ENVIO_4)
        next_state = ESPERA_5;

    else if (state == ESPERA_5)
        next_state = (ready) ? ENVIO_5 : ESPERA_5;
    else if (state == ENVIO_5)
        next_state = ESPERA_6;

    else if (state == ESPERA_6)
        next_state = (ready) ? ENVIO_6 : ESPERA_6;
    else if (state == ENVIO_6)
        next_state = DONE;

    else if (state == DONE)
    next_state = DONE;
end

    always @(*) begin
        valid = 1'b0;
        data = 8'd0;
    if(state == ENVIO_4) begin
        valid = 1'b1;
        data = 8'd4;
    end
    if(state == ENVIO_5) begin
        valid = 1'b1;
        data = 8'd5;
    end
    if (state == ENVIO_6) begin
        valid = 1'b1;
        data = 8'd6;
    end
end
endmodule

