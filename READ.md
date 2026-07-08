------Introduction------
This is the Soft IP Core for a vending machine, designed using an FPGA. The IP core supports three types of coins (10K, 20K, 50K) and three products (A, B, C) with configurable prices.
1. Features
- Supports three types of coins: 10K, 20K, 50K
- Supports three products: A, B, C
- Configurable product prices via parameters
- Configurable timeout
- Buzzer signal (1, 2, 3 beeps)
- Displays the amount on a 7-segment LED (74HC595)
- Three LEDs indicate selected products
- Designed using the Moore FSM model

2. System Architecture

```mermaid
flowchart TD
    subgraph Input_Stage["INPUT STAGE"]
        direction LR
        Coin_10k["coin_10k_n"] --> Debounce["DEBOUNCE (x7)"]
        Coin_20k["coin_20k_n"] --> Debounce
        Coin_50k["coin_50k_n"] --> Debounce
        Btn_A["btn_A_n"] --> Debounce
        Btn_B["btn_B_n"] --> Debounce
        Btn_C["btn_C_n"] --> Debounce
        Reset["reset_n"] --> Debounce
        Debounce --> Pulse_10k["pulse_10k"]
        Debounce --> Pulse_20k["pulse_20k"]
        Debounce --> Pulse_50k["pulse_50k"]
        Debounce --> Pulse_A["pulse_A"]
        Debounce --> Pulse_B["pulse_B"]
        Debounce --> Pulse_C["pulse_C"]
        Debounce --> Pulse_Reset["pulse_reset"]
    end

    subgraph FSM_Controller["FSM CONTROLLER"]
        direction TB
        Pulse_10k --> FSM
        Pulse_20k --> FSM
        Pulse_50k --> FSM
        Pulse_A --> FSM
        Pulse_B --> FSM
        Pulse_C --> FSM
        Pulse_Reset --> FSM

        FSM["MOORE STATE MACHINE
        (IDLE → INSERT_COIN → 
        SELECT_PRODUCT → TIMEOUT → 
        BUZZER_ON → BUZZER_OFF)"]
    end

    subgraph Datapath["DATAPATH"]
        direction TB
        FSM --> Money_Reg["MONEY REGISTER (7-bit)"]
        FSM --> Timeout_Cnt["TIMEOUT COUNTER (4-bit)"]
        FSM --> Buzzer_Ctrl["BUZZER CONTROL"]
        FSM --> Selected_Prod["SELECTED PRODUCT (2-bit)"]
    end

    subgraph Output_Stage["OUTPUT STAGE"]
        direction LR
        Money_Reg --> BCD["BINARY_TO_BCD_2DIGIT"]
        BCD --> Display["DISPLAY_595_DRIVER_2DIGIT"]
        Display --> Seven_Seg["7-SEGMENT DISPLAY (74HC595)"]
        
        Buzzer_Ctrl --> Buzzer_Driver["BUZZER DRIVER"]
        Buzzer_Driver --> Buzzer_Out["buzzer"]
        
        Selected_Prod --> LED_A["led_product_A"]
        Selected_Prod --> LED_B["led_product_B"]
        Selected_Prod --> LED_C["led_product_C"]
    end
