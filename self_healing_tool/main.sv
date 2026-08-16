module self_healing_tool (
    input logic clk,
    input logic rst_n,
    input logic [7:0] data_in,
    input logic valid_in,
    output logic [7:0] data_out,
    output logic valid_out,
    output logic error_detected,
    output logic self_healing_active
);

    // State definitions
    typedef enum logic [2:0] {
        IDLE      = 3'b000,
        VALID     = 3'b001,
        ERROR     = 3'b010,
        HEALING   = 3'b011,
        RECOVERY  = 3'b100
    } state_t;

    state_t current_state, next_state;

    // Internal signals
    logic [7:0] buffer_data;
    logic [31:0] error_counter;
    logic [31:0] max_error_threshold;

    // Parameters
    parameter MAX_ERROR_THRESHOLD = 32'd10;
    parameter HEALING_DELAY = 32'd5;

    // Error detection logic
    assign error_detected = (current_state == ERROR);
    assign self_healing_active = (current_state == HEALING) || (current_state == RECOVERY);

    // Edge case and error handling logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= IDLE;
            buffer_data <= 8'h00;
            valid_out <= 1'b0;
            error_counter <= 32'd0;
        end else begin
            case (current_state)
                IDLE:
                    if (valid_in) begin
                        // Check for edge case: invalid data range
                        if (data_in > 8'h7F) begin
                            current_state <= ERROR;
                            error_counter <= error_counter + 1;
                        end else begin
                            current_state <= VALID;
                            buffer_data <= data_in;
                        end
                    end

                VALID:
                    if (valid_in) begin
                        if (data_in == buffer_data) begin // Consistency check
                            current_state <= VALID;
                        end else begin
                            current_state <= ERROR;
                            error_counter <= error_counter + 1;
                        end
                    end else begin
                        current_state <= IDLE;
                    end

                ERROR:
                    if (error_counter >= MAX_ERROR_THRESHOLD) begin
                        // Self-healing initiated due to excessive errors
                        current_state <= HEALING;
                        error_counter <= 32'd0;
                    end else begin
                        current_state <= IDLE;
                    end

                HEALING:
                    if (HEALING_DELAY > 0) begin
                        current_state <= HEALING;
                    end else begin
                        current_state <= RECOVERY;
                    end

                RECOVERY:
                    begin
                        // Reset state and clear errors
                        buffer_data <= 8'h00;
                        error_counter <= 32'd0;
                        current_state <= IDLE;
                    end

                default:
                    current_state <= IDLE;
            endcase

            // Output logic
            if (current_state == VALID) begin
                data_out <= buffer_data;
                valid_out <= 1'b1;
            end else begin
                data_out <= 8'h00;
                valid_out <= 1'b0;
            end
        end
    end

    // Heuristic edge case handling
    always_comb begin
        // Additional logic to handle rare edge cases
        if (data_in == 8'hFF && valid_in) begin
            // Specific heuristic for 0xFF edge case
            current_state = IDLE;
        end else if (data_in == 8'h00 && !valid_in) begin
            // Specific heuristic for 0x00 edge case
            current_state = IDLE;
        end else begin
            current_state = current_state;
        end
    end

endmodule
