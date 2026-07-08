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
| **Timing Issues**        | Fewer timing issues                                                                             | Potential combinational timing issues                                          |

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
