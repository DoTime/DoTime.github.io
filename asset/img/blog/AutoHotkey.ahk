



;打开文件 指定doc文件


;打开网址
;#c::Run http://www.cnbeta.com/
;#g::Run http://www.dgtle.com/
 
 ;==========================
 

 ;==========================


;打开程序
#o::Run C:\Program Files\Microsoft Office\root\Office16\ONENOTE.EXE
#n::Run C:\Users\feng\AppData\Roaming\Lantern\lantern.exe
;浏览器
#space::Run C:\Program Files (x86)\Google\Chrome\Application\chrome.exe
#c::Run D:\Program work\Xshell 6\Xshell.exe
#q::Run C:\WINDOWS\system32\Taskmgr.exe
;#s::Run D:\Program work\Sublime Text 3\sublime_text.exe
!z::Run D:\Program Files\Telegram Desktop\Telegram.exe

;---垃圾箱
;#c::Run D:\Program system\ConEmuPack\ConEmu64.exe
;#c::Run E:\ProgramFiles\ProgramFile\cmder_mini\Cmder.exe
;#c::Run C:\Users\feng\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Cmder
;#x::Run D:\Program work\Evernote\Evernote.exe
 ;打开系统属性   
 :://sys::   
 Run control sysdm.cpl   
 return   

;修改系统热键映射
#a::Send #e

;显示桌面
#z::Send #d
;锁屏
;<^>^::Send #l


;=============================================
;亮度调节 指针放置状态栏滚动
;#left::MoveBrightness(-1)
;#right::MoveBrightness(1)



;音量设置
;#PgUp::SoundSet +5  ; 将主音量增加 5%
;#PgDn::SoundSet -5  ; 将主音量减小 5%

;=====================================


;鼠标放在任务栏，滚动滚轮实现音量的加减
~lbutton & enter::  
exitapp  
~WheelUp::  
if (existclass("ahk_class Shell_TrayWnd")=1)  
    Send,{Volume_Up}  
Return  
~WheelDown::  
if (existclass("ahk_class Shell_TrayWnd")=1)  
    Send,{Volume_Down}  
Return  
~MButton::  
if (existclass("ahk_class Shell_TrayWnd")=1)  
    Send,{Volume_Mute}  
Return  

Existclass(class){  
    MouseGetPos,,,win  
    WinGet,winid,id,%class%  
    if win = %winid%  
    Return,1  
    Else  
    Return,0  
}


;=============================================
;双击esc实现关闭窗口

~Esc::
Keywait, Escape, , t0.5
if errorlevel = 1
return
else
Keywait, Escape, d, t0.1
if errorlevel = 0
{
WinGetActiveTitle, Title
WinClose, %Title%
return
}
return
;=============================================
 


;=============================================
;chrome浏览器
;Surfingkeys不能控制浏览器系统标签,使用该脚本控制修改按键映射
; 下面的语句块只在chrome中生效
;
 
#IfWinActive ahk_class Chrome_WidgetWin_1
    ;q::Send ^w
    ;+r::Send ^`t
    ;+{ASC 65}::Send ^+`t
    ;{U+nnnn}::Send ^w
return 

;=============================================
;使用大写按键拖动窗口
; 注意: 在按下鼠标按钮后您可以释放 Capslock 或鼠标中键
; 而不需要在整个拖动过程中按住它.
; 此脚本需要 v1.0.25+.

~MButton & LButton::
CapsLock & LButton::
CoordMode, Mouse  ; 切换到屏幕/绝对坐标.
MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin% 
if EWD_WinState = 0  ; 仅在窗口不处于最大化状态时
    SetTimer, EWD_WatchMouse, 10 ; 在用户拖动时跟踪鼠标.
return

EWD_WatchMouse:
GetKeyState, EWD_LButtonState, LButton, P
if EWD_LButtonState = U  ; 按钮已经释放, 所以拖动结束.
{
    SetTimer, EWD_WatchMouse, off
    return
}
GetKeyState, EWD_EscapeState, Escape, P
if EWD_EscapeState = D  ; 按下了 Escape, 所以取消拖动.
{
    SetTimer, EWD_WatchMouse, off
    WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
    return
}
; 否则, 改变窗口的位置以匹配
; 用户拖动鼠标引起的鼠标坐标变化:
CoordMode, Mouse
MouseGetPos, EWD_MouseX, EWD_MouseY
WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
SetWinDelay, -1   ; 让下面的移动更快速/平滑.
WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
EWD_MouseStartX := EWD_MouseX  ; 为下一次调用此子程序进行更新.
EWD_MouseStartY := EWD_MouseY
return


;=============================================

