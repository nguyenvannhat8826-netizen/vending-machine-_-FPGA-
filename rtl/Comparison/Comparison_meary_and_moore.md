# Moore vs Mealy FSM Comparison for Vending Machine

 Overview Comparison

| Feature                  | Moore                                                                                           | Mealy                                                                          |
|--------------------------|-------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------|
| **Number of States**     |6 states                                                                                         | 5 states                                                                       |
| **State Encoding**       | IDLE(000), INSERT_COIN(001), SELECT_PRODUCT(010), TIMEOUT(011), BUZZER_ON(100), BUZZER_OFF(101) | IDLE(000), INSERT_COIN(001), SELECT_PRODUCT(010), TIMEOUT(011), BUZZER_ON(100) |
| **Output Dependency**    | Depends only on current state                                                                   | Depends on current state + inputs                                              |
| **Output Timing**        | 1 clock cycle delay (synchronous)                                                               | 0 clock cycle delay (combinational)                                            |
| **Speed**                | Slower                                                                                          | Faster                                                                         |
| **Resource Usage**       | More LUTs & FFs                                                                                 | Less LUTs & FFs                                                                |
| **Design Complexity**    | Simple, easy to understand                                                                      | More complex, harder to debug                                                  |
| **Glitch**               | None                                                                                            | Possible                                                                       |

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
A. Moore FSM (6 States)
State Descriptions:
- IDLE (000)           : Waiting for coin insertion or product selection
- INSERT_COIN (001)    : Accepting coins, counting money
- SELECT_PRODUCT (010) : Processing product selection
- TIMEOUT (011)        : Timeout occurred, resetting
- BUZZER_ON (100)      : Buzzer is active
- BUZZER_OFF (101)     : Buzzer is turned off, returning to operation

B. Mealy FSM (5 States)
State Descriptions:
- IDLE (000)           : Waiting for coin insertion or product selection
- INSERT_COIN (001)    : Accepting coins, counting money
- SELECT_PRODUCT (010) : Processing product selection
- TIMEOUT (011)        : Timeout occurred, resetting
- BUZZER_ON (100)      : Buzzer is active (output determined by state + input)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### Resource Utilization Summary

| Resource | Moore | Mealy | Improvement |
|----------|-------|-------|-------------|
| **LUTs** | 295 | 290 | **-1.69%** |
| **Flip-Flops** | 282 | 280 | **-0.71%** |
| **Logic** | 517 | 512 | **-0.97%** |
| **Fmax** | 223.2 MHz | 222.8 MHz | -0.18% |
| **Worst Slack** | 5.520 ns | 5.512 ns | -0.14% |
| **Logic Level** | 8 | 8 | 0% |

* Implementation Differences

In this design:
### Implementation Code Comparison

#### Moore:
```verilog
assign buzzer = buzz_state;  
```
#### Mealy:
```verilog
always @(*) begin
    buzzer_mealy = 1'b0;
    case (current_state)
        BUZZER_ON: begin
            if (buzz_active && buzz_state_reg)
                buzzer_mealy = 1'b1;
        end
    endcase
end
assign buzzer = buzzer_mealy;
```
 Resource Utilization Comparison

| Resource | Moore | Mealy | Improvement |
|----------|-------|-------|-------------|
| **LUTs** | 295   | 290   | -1.69%      |
| **Flip-Flops** | 282 | 280 | -0.71% |
| **Fmax** | 223.2 MHz | 222.8 MHz | -0.18% |

- The Mealy implementation uses slightly fewer resources (5 LUTs and 2 FFs) 
due to having one fewer state (5 vs 6). However, the Moore implementation 
achieves a slightly higher maximum frequency (223.2 MHz vs 222.8 MHz). 
Both designs exceed the 100 MHz requirement.
- While Mealy saves resources, the difference is minimal 
in this design. The main advantage of Mealy is the reduced state count, 
which simplifies the state machine.

* Trade-offs
- Moore is preferred for **safety-critical applications** where stability matters
- Mealy is preferred for **high-speed applications** where performance matters
  
* Conclusion
The Mealy implementation in this design uses **1 fewer state** (5 vs 6), requires fewer FFs, and achieves  higher Fmax, but requires careful glitch analysis due to its combinational output logic.
