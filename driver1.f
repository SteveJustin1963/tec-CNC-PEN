\ Hardware Constants
2 CONSTANT X_MOTOR_STEP   \ IO port for X-axis stepper motor step signal
3 CONSTANT X_MOTOR_DIR    \ IO port for X-axis stepper motor direction signal
4 CONSTANT Y_MOTOR_STEP   \ IO port for Y-axis stepper motor step signal
5 CONSTANT Y_MOTOR_DIR    \ IO port for Y-axis stepper motor direction signal
6 CONSTANT Z_PEN_UPDOWN   \ IO port for pen up/down control

\ Initialize IO ports
: INIT-IO-PORTS
  X_MOTOR_STEP 0 OUT
  X_MOTOR_DIR  0 OUT
  Y_MOTOR_STEP 0 OUT
  Y_MOTOR_DIR  0 OUT
  Z_PEN_UPDOWN 0 OUT
;

\ Stepper motor control words
: MOVE-X ( steps -- )
  DUP 0< IF X_MOTOR_DIR 1 OUT ELSE X_MOTOR_DIR 0 OUT THEN
  ABS X_MOTOR_STEP 1 OUT 0 OUT
;

: MOVE-Y ( steps -- )
  DUP 0< IF Y_MOTOR_DIR 1 OUT ELSE Y_MOTOR_DIR 0 OUT THEN
  ABS Y_MOTOR_STEP 1 OUT 0 OUT
;

\ Pen control words
: PEN-UP   Z_PEN_UPDOWN 1 OUT ;
: PEN-DOWN Z_PEN_UPDOWN 0 OUT ;

\ Main word to process G-code commands
: PROCESS-GCODE ( gcode -- )
  CASE
    \ G0: Rapid positioning (move without pen)
    "G0" OF DROP MOVE-X MOVE-Y PEN-UP ENDOF

    \ G1: Linear interpolation (move with pen)
    "G1" OF DROP MOVE-X MOVE-Y PEN-DOWN ENDOF

    \ G28: Home position (move to origin)
    "G28" OF DROP 0 0 MOVE-X MOVE-Y PEN-UP ENDOF

    \ Unsupported G-code commands
    \ Add additional cases here if needed

    \ Default case: Unsupported command
    DROP ." Unsupported G-code command" CR
  ENDCASE
;

\ Read G-code from serial terminal and return it
: READ-GCODE
  BLK @ 0 ERASE  \ Clear input buffer
  BEGIN
    BLK @ 0 256 ACCEPT \ Read input from serial terminal
    DUP 0= UNTIL
  ;

\ Example usage
: EXAMPLE
  INIT-IO-PORTS       \ Initialize IO ports
  "G28" PROCESS-GCODE \ Move to origin (home position)

  BEGIN
    CR ." Enter G-code (or 'q' to quit): "
    READ-GCODE DUP ." Processing: " TYPE CR
    DUP "q" <> WHILE
      DROP PROCESS-GCODE
      CR ." Enter G-code (or 'q' to quit): "
    REPEAT
  DROP
;

EXAMPLE
