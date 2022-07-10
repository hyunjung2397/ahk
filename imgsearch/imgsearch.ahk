^F7::
CoordMode, Pixel, Screen

IniRead, variation, setup.ini, searchoption, variation
IniRead, transN, setup.ini, searchoption, transN
IniRead, interval, setup.ini, searchoption, interval
IniRead, wait, setup.ini, searchoption, wait
IniRead, imgpath, setup.ini, searchoption, imgpath
IniRead, ringfile, setup.ini, searchoption, ringfile

mon1 = 0
mon2 = 0
mon3 = 0
mon4 = 0
mon5 = 0

mon1array := {Left: 0, Top: 0, Right: 0, Bottom: 0}
mon2array := {Left: 0, Top: 0, Right: 0, Bottom: 0}
mon3array := {Left: 0, Top: 0, Right: 0, Bottom: 0}
mon4array := {Left: 0, Top: 0, Right: 0, Bottom: 0}
mon5array := {Left: 0, Top: 0, Right: 0, Bottom: 0}

SysGet, moncount, MonitorCount

Loop, %moncount%
{
 IniRead, mon%A_Index%, setup.ini, monitoroption, mon%A_Index%

 if (mon%A_Index% == 1) 
 {
  SysGet, mon%A_Index%, Monitor, %A_Index%
  mon%A_Index%array["Left"] := mon%A_Index%Left
  mon%A_Index%array["Top"] := mon%A_Index%Top
  mon%A_Index%array["Right"] := mon%A_Index%Right
  mon%A_Index%array["Bottom"] := mon%A_Index%Bottom
 }
}

imgs := []

Loop, Files, %imgpath%
{
 imgs.Push(A_LoopFileShortPath)
}

msgbox, Start

Loop
{
 Loop, 5
 {
  if (mon%A_Index%)
  {
   for k, v in imgs
   {
    ImageSearch, X, Y, mon%A_Index%array["Left"], mon%A_Index%array["Top"], mon%A_Index%array["Right"], mon%A_Index%array["Bottom"], *Trans%transN% *%variation% %v%

    if (errorlevel == 0)
    {
     SoundPlay, %ringfile%
     Sleep, %wait%
     Break
    }
   }
  }
 }

 Sleep, %interval%
}

return

^F8::
Pause, Toggle, 1

if (A_IsPaused)
{
 msgbox, Pause On
} else
{
 msgbox, Pause Off
}

return

^F9::
msgbox, ExitApp

ExitApp
