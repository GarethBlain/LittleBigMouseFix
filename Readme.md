# Little Big Mouse - Unplug Fix

## Description

This is a simple AutoHotKey script that adds a tray icon to the Windows Taskbar with the ability to stop
and then re-start the LittleBigMouse's Daemon every time the monitors change (unplugged or plugged in).

This will force LBM to reload it's monitor list/layout and prevent the mouse being locked in a strange
location on the monitor!

## Usage

Once started this will look out for monitors being unplugged/plugged in and when that occurs it will
automatically restart LBM so it picks up the new monitor layout.

Double clicking the icon (or using the right click menu and selecting "Restart LittleBigMouse") will manually
stop, wait a second and restart LBM's service. This shouldn't need to be done manually.

## Compiling/Installing

This script can (and should) be compiled into an exe using [AutoHotKey](https://www.autohotkey.com/).

Once compiled into an application you can add a shortcut to the app into your Windows Startup folder so it
runs every time windows starts.
