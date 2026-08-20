;<CsoundSynthesizer>
CsVersion 500
; Real-time audio synthesis and processing engine

<ControlMode>Init</ControlMode>

Orchestra

; Define a basic sine wave oscillator instrument
instr 1
  ; Input frequencies from MIDI or score
  iFreq = p4
  iAmp = p5
  
  ; Generate sine wave
  aOut oscil iAmp, iFreq
  
  ; Output audio
  outa aOut
  outa aOut
endin

; Define an amplitude envelope

; Score
Score
  ; Instrument 1, start time, duration, frequency, amplitude
  i1 0 1 440 0.5
  i1 2 1 440 0.5
  i1 4 1 440 0.5
endScore
;</CsoundSynthesizer>
