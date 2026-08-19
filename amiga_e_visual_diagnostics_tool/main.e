/*
 * Amiga E Visual Diagnostic and Visualization Tool
 * 
 * Provides interactive waveform display, data tracking, and system monitoring
 * using Amiga E graphics primitives.
 */

Include "clib/dos_protos.i"
Include "clib/exec_protos.i"
Include "clib/graphi_protos.i"
Include "clib/intuition_protos.i"

#define WIDTH 640
#define HEIGHT 480
#define BUFFER_SIZE 1024

Type SampleData
  values[BUFFER_SIZE] : Long
  count : Long
  offset : Long
EndType

Type WindowInfo
  window : Window
  bitmap : Bitmap
  screen : Screen
EndType

Global wd : WindowInfo
Global sData : SampleData
Global running : Bool
Global zoom : Long
Global scroll : Long

/* Function prototypes */
Procedure init_graphics()
Procedure cleanup_graphics()
Procedure main_loop()
Procedure render_waveform()
Procedure draw_grid()
Procedure draw_data_points()
Procedure handle_events()
Function generate_sample(t : Long) : Float
Function clamp(val : Float, min : Float, max : Float) : Float

/* Initialize graphics environment */
Procedure init_graphics()
  Screen(0, 0, 0, 0, 0)
  wd.screen = GetScreenObject(0)
  wd.window = OpenWindow(0, WIDTH/4, HEIGHT/4, WIDTH/2, HEIGHT/2, "Visual Diagnostics")
  wd.bitmap = Bitmap(0, WIDTH, HEIGHT)
  
  /* Initialize sample data */
  sData.count = 0
  sData.offset = 0
EndProcedure

/* Cleanup graphics resources */
Procedure cleanup_graphics()
  CloseWindow(wd.window)
  FreeBitmap(wd.bitmap)
EndProcedure

/* Generate sample data point */
Function generate_sample(t : Long) : Float
  Var freq1, freq2, phase : Float
  freq1 = 0.05
  freq2 = 0.1
  phase = t * 0.01
  
  Result = Sin(freq1 * t + phase) * 0.5 + 
           Sin(freq2 * t + phase * 2.0) * 0.3 + 
           Random(0.05)
EndFunction

/* Clamp value between min and max */
Function clamp(val : Float, min : Float, max : Float) : Float
  If val < min Result = min Else 
  If val > max Result = max Else 
  Result = val
End If
EndIf
End Function

/* Draw grid lines */
Procedure draw_grid()
  Var x, y : Long
  
  /* Vertical grid lines */
  For x = 0 To WIDTH Step 40
    Line(x, 0, x, HEIGHT)
  Next
  
  /* Horizontal grid lines */
  For y = 0 To HEIGHT Step 40
    Line(0, y, WIDTH, y)
  Next
  
  /* Center axes */
  Line(WIDTH/2, 0, WIDTH/2, HEIGHT)
  Line(0, HEIGHT/2, WIDTH, HEIGHT/2)
EndProcedure

/* Render waveform */
Procedure render_waveform()
  Var t : Long
  Var x, y : Long
  Var val : Float
  
  /* Clear screen */
  ClearScreen(0, 0, WIDTH, HEIGHT)
  
  /* Draw grid */
  draw_grid()
  
  /* Draw waveform */
  For t = 0 To sData.count - 1
    If t >= scroll Then
      x = (t - scroll) * (WIDTH / 200)
      If x >= WIDTH Then Continue
      
      val = (sData.values[t] / 10000.0)
      y = HEIGHT/2 + (val * HEIGHT/2)
      y = clamp(y, 0, HEIGHT)
      
      /* Draw point */
      Point(x, y)
      
      /* Draw connecting line */
      If t > 0 Then
        If t - 1 >= scroll Then
          x_prev = (t - 1 - scroll) * (WIDTH / 200)
          val_prev = (sData.values[t-1] / 10000.0)
          y_prev = HEIGHT/2 + (val_prev * HEIGHT/2)
          y_prev = clamp(y_prev, 0, HEIGHT)
          
          Line(x_prev, y_prev, x, y)
        EndIf
      EndIf
    EndIf
  Next
EndProcedure

/* Draw data points */
Procedure draw_data_points()
  Var t : Long
  
  For t = sData.count - 5 To sData.count - 1
    If t >= 0 Then
      x = (t - scroll) * (WIDTH / 200)
      val = (sData.values[t] / 10000.0)
      y = HEIGHT/2 + (val * HEIGHT/2)
      
      /* Draw point marker */
      Circle(x, y, 3)
    EndIf
  Next
EndProcedure

/* Handle keyboard events */
Procedure handle_events()
  Var key : Long
  
  While Keys()
    key = GetKbCode()
    
    /* Space: pause/resume */
    If key = 32 Then
      running = !running
    EndIf
    
    /* R: reset data */
    If key = 82 Then
      sData.count = 0
      sData.offset = 0
      scroll = 0
    EndIf
    
    /* Z: toggle zoom */
    If key = 90 Then
      zoom = (zoom = 1) ? 2 : 1
    EndIf
    
    /* Arrow keys: scroll */
    If key = 203 Then /* Left */
      scroll = Max(0, scroll - 10)
    EndIf
    If key = 205 Then /* Right */
      scroll = Min(scroll + 10, sData.count - 200)
    EndIf
    
    /* Q: quit */
    If key = 81 Then
      running = False
    EndIf
  EndWhile
EndProcedure

/* Generate new samples */
Procedure generate_samples()
  Var i : Long
  
  For i = 0 To 10
    If sData.count < BUFFER_SIZE Then
      sData.values[sData.count] = Long(generate_sample(sData.count) * 10000)
      sData.count++
    Else
      /* Shift data left */
      MoveArray(sData.values[0], sData.values[1], (BUFFER_SIZE-1) * SizeOf(Long))
      sData.values[BUFFER_SIZE-1] = Long(generate_sample(sData.count) * 10000)
      sData.offset++
    EndIf
  Next
EndProcedure

/* Main program loop */
Procedure main_loop()
  Var start_time : Long
  
  running = True
  start_time = IExec.Time()
  
  While running
    /* Generate new data */
    generate_samples()
    
    /* Render visualization */
    render_waveform()
    draw_data_points()
    
    /* Handle user input */
    handle_events()
    
    /* Throttle frame rate */
    WaitTOF()
  EndWhile
EndProcedure

/* Main entry point */
Begin
  Print("Visual Diagnostic Tool v1.0")
  Print("Controls: Space=Pause, R=Reset, Z=Zoom, Q=Quit")
  
  init_graphics()
  main_loop()
  cleanup_graphics()
  
  Print("Tool exited successfully")
End
