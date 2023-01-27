#Persistent ; Keeps the script running until AppKill is run
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#SingleInstance, Force

; ---------------------------------
; Version 1.1.0
; ---------------------------------

TrayLabel := "Little Big Mouse - Unplug Fix"
Global SettingFilePath := "Settings.ini"

; Pull the settings out of the settings Setting File (and store them if missing)
Global AutoRestart := IniReadPipe("Main", "AutoRestart", 1)
Global WaitBeforeRestart := IniReadPipe("Main", "WaitBeforeRestart", 5000)

; Check that the icons exist
if (!FileExist(A_ScriptDir . "\LBMFix.ico")) {
  ; 262160 = 16 Icon Hand (stop/error) & 262144 Always on top
  Msgbox, 262160, %MsgBoxHeader%, Error: Icon missing!
}

; Set the tray icon image
Menu, Tray, Icon, %A_ScriptDir%\LBMFix.ico

; Set the tray icon label
Menu, Tray, Tip, %TrayLabel%

; Remove default tray menu entries
Menu, Tray, NoStandard
; Add a new tray menu entry
Menu, Tray, Add, Restart LittleBigMouse, RestartDaemon
; Make this the default entry (double clicking triggers it)
Menu, Tray, Default, Restart LittleBigMouse
; Add tray menu entries to enable/disable
if (AutoRestart){
  Menu, Tray, Add, Disable AutoRestart, ToggleAutoRestart
} Else {
  Menu, Tray, Add, Enable AutoRestart, ToggleAutoRestart
}
; Add another tray menu entry to exit app
Menu, Tray, Add, Exit, Exit

; Catch any monitor changes and run the RestartDaemon code
OnMessage(0x007E, "RestartDaemon")

; This simply stops (and optionally restarts) the Little Big Mouse deamon to force it to look at the monitors...
RestartDaemon() {
  ; Stop LBM
  Run, "C:\Program Files\LittleBigMouse\LittleBigMouse_Daemon.exe" --exit

  If (AutoRestart) {
    ; Wait for a bit
    Sleep, WaitBeforeRestart
    ; Restart LBM
    Run, "C:\Program Files\LittleBigMouse\LittleBigMouse_Daemon.exe" --start
  }
}

ToggleAutoRestart() {
  If (AutoRestart) {
    Menu, Tray, Rename, Disable AutoRestart, Enable AutoRestart
    SetSetting("Main", "AutoRestart", false)
  } Else {
    Menu, Tray, Rename, Enable AutoRestart, Disable AutoRestart
    SetSetting("Main", "AutoRestart", true)
  }
}

SetSetting(SectionName, KeyName, NewValue) {
  IniWrite, %NewValue%, %SettingFilePath%, % SectionName, % KeyName
  %KeyName% := NewValue
}

IniReadPipe(SectionName, KeyName, Default) {
  IniRead, OutputVar, %SettingFilePath%, % SectionName, % KeyName
  If (OutputVar == "ERROR") {
    IniWrite, %Default%, %SettingFilePath%, % SectionName, % KeyName
    Return %Default%
  }
  Return %OutputVar%
}

Exit() {
  ExitApp
}
