; Info about this message # here: https://www.autohotkey.com/docs/misc/SendMessageList.htm
OnMessage(0x007E, "monitorChange")
monitorChange() {
  ; Stop LBM
  Run, "C:\Program Files\LittleBigMouse\LittleBigMouse_Daemon.exe" --stop

  ; Wait for a bit
  Sleep, 100

  ; Restart LBM
  Run, "C:\Program Files\LittleBigMouse\LittleBigMouse_Daemon.exe" --start
}


;   Msgbox, 262160, %MsgBoxHeader%, Monitor Changed!
;   SysGet, newMonitorCount, MonitorCount
;   if(newMonitorCount > 1) {
;     ; Trying to be specific to my home office monitor.
;     ; If specificity is not desired, remove the following SysGet and extract the Run statement from the if block.
;     ; SysGet name, MonitorName
;     ; if("\.\DISPLAY2" = name) {
;       Run, LittleBigMouse_Control.exe, C:\Program Files\LittleBigMouse
;     ; }
;     Msgbox, 262160, %MsgBoxHeader%, Trying to open LBM
;   }
;   if(1 = newMonitorCount) {
;     ; Tried a dozen ways to kill it and finally found this one that works
;     Run wmic process where name='LittleBigMouse_Daemon.exe' delete
;     Msgbox, 262160, %MsgBoxHeader%, Only one monitor... Tried to kill LBM!
;   }
; }