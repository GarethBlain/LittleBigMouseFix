#Persistent
#SingleInstance, force

global TrayLabel := "Little Big Mouse - Unplug Fix"

; Set the tray icon label
Menu, Tray, Tip, %TrayLabel%

; Remove default tray menu entries
Menu, Tray, NoStandard
; Add a new tray menu entry
Menu, Tray, Add, Restart LittleBigMouse, RestartDaemon
; Make this the default entry (double clicking triggers it)
Menu, Tray, Default, Restart LittleBigMouse
; Add another tray menu entry
Menu, Tray, Add, Exit, Exit

; Catch any monitor changes and run the RestartDaemon code
OnMessage(0x007E, "RestartDaemon")

; This simply restarts the Little Big Mouse deamon to force it to look at the monitors...
RestartDaemon() {
  ; Stop LBM
  Run, "C:\Program Files\LittleBigMouse\LittleBigMouse_Daemon.exe" --stop

  ; Wait for a bit
  Sleep, 100

  ; Restart LBM
  Run, "C:\Program Files\LittleBigMouse\LittleBigMouse_Daemon.exe" --start
}

Exit() {
  ExitApp
}
