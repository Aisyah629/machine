' Spin Realtime Scheduler Tool
' Manages concurrent object execution and inter-object communication
' for the Parallax Propeller microcontroller.

CON
  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000

  NUM_COGS = 8
  MSG_SIZE = 32

OBJ
  cogmgr : "CogManager"
  msgsys : "MessageSystem"

VAR
  long stack1[64]
  long stack2[64]
  long stack3[64]
  long stack4[64]

PUB main
  cogmgr.init()
  msgsys.init()
  
  ' Start background tasks in separate cogs
  cogmgr.new(@task_a, stack1, 64, 0) 
  cogmgr.new(@task_b, stack2, 64, 0)
  cogmgr.new(@task_c, stack3, 64, 0)
  
  repeat
    ' Main loop can handle UI or other high-level logic
    waitcnt(clkfreq / 10 + cnt)

PUB task_a
  msgsys.send(1, "A Started")
  repeat
    msgsys.send(1, "A Tick")
    waitcnt(clkfreq / 2 + cnt)

PUB task_b
  repeat
    waitcnt(clkfreq / 4 + cnt)
    msgsys.send(1, "B Tick")

PUB task_c
  repeat
    waitcnt(clkfreq / 8 + cnt)
    msgsys.send(1, "C Tick")
