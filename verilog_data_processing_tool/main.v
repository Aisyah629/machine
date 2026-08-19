// Verilog Data Processing Tool
// File: main.v

module verilog_data_processor(
    input wire clk,
    input wire rst,
    input wire [15:0] data_in,
    input wire valid_in,
    output reg [15:0] data_out,
    output reg valid_out
);

    reg [15:0] accumulator;
    reg [3:0] counter;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            accumulator <= 0;
            counter <= 0;
            data_out <= 0;
            valid_out <= 0;
        end else if (valid_in) begin
            accumulator <= accumulator + data_in;
            counter <= counter + 1;
            data_out <= accumulator;
            valid_out <= 1;
        end else begin
            valid_out <= 0;
        end
    end

endmodule
