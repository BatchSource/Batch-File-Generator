@echo off

title Batch File Generator [Version v0.2.0] - By Alex
color 0a
echo Hello!
timeout 1 >nul
echo Press any key to begin!
pause >nul
cls
echo What do you want to do?
echo.
echo OPTIONS:
CHOICE /C NO /M "Press N for new, and O to open"
	If %ERRORLEVEL% equ 1 goto createbatch
	If %ERRORLEVEL% equ 2 goto openbatch
	
REM --------OPEN--------
:openbatch
echo CANNOT BE AN EXE FILE!
set /p openloc=Click and drag the file here and press enter: 
cls
color 7
call %openloc%
exit
	
REM --------NEW---------

REM Type of Batch
:createbatch

cls

REM CHOOSE DIRECTORY

CHOICE /C YN /M "Batch file directory is %USERPROFILE%\Desktop. Do you want to change this?"
	If %ERRORLEVEL% equ 1 goto changedir
	If %ERRORLEVEL% equ 2 goto dirisok
	
	
REM IF DIR IS NOT OK
:changedir
echo.
echo Please click and drag the folder you wish to set your directory to here and press enter.
set /p batdir= Directory: 
if NOT EXIST %batdir% echo ERROR! COULD NOT FIND %batdir%. PLEASE TRY AGAIN. & cls & goto changedir
goto dirisset

REM IF DIR IS OK
:dirisok

set batdir=%USERPROFILE%\Desktop

:dirisset
echo Directory set to %batdir%.
cd %batdir%
echo.
echo DO NOT USE SPACES!

:setthenameagain
		set /P name= Name this file: 
		if NOT EXIST %name%.bat goto good
			
			
			set /a id= 0
		
			:nameforloop
		
				set /a id= %id% + 1
		
				if EXIST %name%%id%.bat goto nameforloop
							

echo.
echo ERROR! File "%name%" already exists. 
set name=%name%%id%
echo Naming the file %name% instead...

timeout 1 >nul

:good
echo.
cls
	echo File named "%name%".
	title File named "%name%".
echo.
	timeout 1 >nul
echo @ECHO OFF >> %name%.bat



cls
echo What type of batch file do you want to make?
echo.
echo Press N for Normal
echo Normal will allow you to run basic commands. This will not create a popup.
echo -------------------------
echo Press H for High level commands.
echo This will allow you to create high level commands such as closing and executing tasks, deleting files, and adding or removing directories. The user will be warned if they are about the execute this type of file (unless they are on 
echo Windows 10 home)
echo.
CHOICE /C NH3 /n
	If %ERRORLEVEL% equ 3 goto hackerman
	If %ERRORLEVEL% equ 2 goto highlvlon
	If %ERRORLEVEL% equ 1 set fixgoto=REM & goto highlvloff
	
:highlvlon
echo msg * /w WARNING! THIS BATCH FILE HAS HIGHLEVEL COMMANDS! IT HAS ACCESS TO EXECUTE PROGRAMS, REMOVE OR CREATE DIRECTORIES, AND DELETE FILES. CLOSE THE CMD WINDOW TO CANCEL, OR PRESS OK TO BEGIN. >> %name%.bat
echo cls >> %name%.bat
:hackerman
cls
set fixgoto=goto highlevelcommands


:highlvloff
cls
REM -----BATCH IS CREATED! TIME FOR CREATE PART
set /a lofm= -1
:nextcm

set /a lofm= %lofm% + 1

if %lofm% NEQ 1 set gramar=s
if %lofm% EQU 1 set gramar=s

:codeshowexit
title Writing to "%name%.bat"... %lofm% command%gramar%
%fixgoto%

echo OPTIONS:
echo.
echo Press 1 to change color
echo Press 2 to say words
echo Press 3 to wait for a specified amount of seconds
echo Press 4 to wait for a keystroke before continuing
echo Press 5 to display a popup box (Not avaliable on Windows 10 Home)
echo Press 6 to clear the text
echo Press 7 to title the prompt
echo Press 8 to scan entire system (may take a while)
echo.
echo Press Z to see how much code you have so far.
echo Press X to exit
echo.
CHOICE /C 12345678XZ /N /M "Option: "

	If %ERRORLEVEL% equ 1 goto colorcom
	If %ERRORLEVEL% equ 2 goto echocom
	If %ERRORLEVEL% equ 3 goto timeoutcom
	If %ERRORLEVEL% equ 4 goto pausecom
	If %ERRORLEVEL% equ 5 goto msgcom
	If %ERRORLEVEL% equ 6 goto clscom
	If %ERRORLEVEL% equ 7 goto titlecom
	If %ERRORLEVEL% equ 8 goto dircom
	If %ERRORLEVEL% equ 9 goto goodbye
	If %ERRORLEVEL% equ 10 goto codeshow



REM SHOW CODE
:codeshow
cls
type %name%.bat
echo.
pause

cls & goto codeshowexit
REM ---CLS
echo.
:clscom
echo cls >> %name%.bat
echo Cls added
timeout 1 >nul
cls & goto nextcm
REM ---DIR
echo.
:dircom
echo cd.. >> %name%.bat
echo cd.. >> %name%.bat
echo cd.. >> %name%.bat
echo cd.. >> %name%.bat
echo cd.. >> %name%.bat
echo cd.. >> %name%.bat
echo cd.. >> %name%.bat
echo cd.. >> %name%.bat
echo cd.. >> %name%.bat
echo dir /s >> %name%.bat

echo Dir added
timeout 1 >nul
cls & goto nextcm


REM ---TITLE
:titlecom
echo.
echo Type what you want it to be titled:
set /p title1=
echo title %title1% >> %name%.bat

cls & goto nextcm
REM ---MSG
:msgcom
echo.
echo Type what you want it to say:
set /p msg1=
echo.
CHOICE /C YN /M "Should it time out?"
	If %ERRORLEVEL% equ 1 goto msg3
	If %ERRORLEVEL% equ 2 set /a msg2=0 & goto msg4
:msg3
echo.
echo NUMBERS ONLY (SECONDS)
set /p msg2=How long should it stay on screen?: 
:msg4
echo msg * /time:%msg2% "%msg1%" >> %name%.bat

cls & goto nextcm
REM ---PAUSE
:pausecom
echo.
echo pause ^>nul >> %name%.bat
echo Pause added
timeout 1 >nul
cls & goto nextcm	

REM ---TIMEOUT
:timeoutcom
echo.
echo NUMBERS ONLY (SECONDS)
set /p timeout1= How many seconds will it wait? : 
echo timeout %timeout1% ^>nul >> %name%.bat

cls & goto nextcm	

REM ---ECHO
:echocom
echo.
echo Type what you want it to say:
set /p echo1=
if /I "%echo1%" EQU "false" echo echo: >> %name%.bat & goto echo2
echo echo:%echo1% >> %name%.bat
set echo1=false
:echo2
echo.
CHOICE /C YN /M "Should it wait for a keystroke before continuing?"
	If %ERRORLEVEL% equ 1 echo pause >> %name%.bat

cls & goto nextcm

REM ---COLOR
:colorcom
CHOICE /C FB /M "Do you want to set the font color or background color?"
	If %ERRORLEVEL% equ 1 set colorcom1=font
	If %ERRORLEVEL% equ 2 set colorcom1=background


echo.
echo What color should the %colorcom1% be?
echo K for BLACK (cannot have black text on black background)
echo B for BLUE
echo G for GREEN
echo A for AQUA
echo R for RED
echo P for PURPLE
echo W for WHITE
choice /C BGARPYWK

if /I "%colorcom1%" EQU "background" goto colorcom2
	If %ERRORLEVEL% equ 8 echo color 0 >> %name%.bat
	If %ERRORLEVEL% equ 1 echo color 1 >> %name%.bat
	If %ERRORLEVEL% equ 2 echo color 2 >> %name%.bat
	If %ERRORLEVEL% equ 3 echo color 3 >> %name%.bat
	If %ERRORLEVEL% equ 4 echo color 4 >> %name%.bat
	If %ERRORLEVEL% equ 5 echo color 5 >> %name%.bat
	If %ERRORLEVEL% equ 6 echo color 6 >> %name%.bat
	If %ERRORLEVEL% equ 7 echo color 7 >> %name%.bat
cls & goto nextcm

:colorcom2
	If %ERRORLEVEL% equ 8 echo color 07 >> %name%.bat
	If %ERRORLEVEL% equ 1 echo color 10 >> %name%.bat
	If %ERRORLEVEL% equ 2 echo color 20 >> %name%.bat
	If %ERRORLEVEL% equ 3 echo color 30 >> %name%.bat
	If %ERRORLEVEL% equ 4 echo color 40 >> %name%.bat
	If %ERRORLEVEL% equ 5 echo color 50 >> %name%.bat
	If %ERRORLEVEL% equ 6 echo color 60 >> %name%.bat
	If %ERRORLEVEL% equ 7 echo color f0 >> %name%.bat

cls & goto nextcm
	

REM ----HIGH LEVEL----


exit
:highlevelcommands
echo OPTIONS:
echo.
echo Press 1 to change color
echo Press 2 to say words
echo Press 3 to wait for a specified amount of seconds
echo Press 4 to wait for a keystroke before continuing
echo Press 5 to display a popup box (Not avaliable on Windows 10 Home)
echo Press 6 to clear the text
echo Press 7 to title the prompt
echo Press 8 to scan entire system
echo Press A to start a program
echo Press B to close a program
echo Press C to make a folder
echo Press D to delete a folder
echo Press E to delete a file
echo.
echo Press Z to see how much code you have so far.
echo Press X to exit
echo.
CHOICE /C 12345678ABCDEXZ /N /M "Option: "

		If %ERRORLEVEL% equ 1 goto colorcom
		If %ERRORLEVEL% equ 2 goto echocom
		If %ERRORLEVEL% equ 3 goto timeoutcom
		If %ERRORLEVEL% equ 4 goto pausecom
		If %ERRORLEVEL% equ 5 goto msgcom
		If %ERRORLEVEL% equ 6 goto clscom
		If %ERRORLEVEL% equ 7 goto titlecom
		If %ERRORLEVEL% equ 8 goto dircom
	If %ERRORLEVEL% equ 9 goto startcom
	If %ERRORLEVEL% equ 10 goto taskkillcom
	If %ERRORLEVEL% equ 11 goto mkdircom
	If %ERRORLEVEL% equ 12 goto rmdircom
	If %ERRORLEVEL% equ 13 goto delcom
		If %ERRORLEVEL% equ 14 goto goodbye
		If %ERRORLEVEL% equ 15 goto codeshow

REM --DEL
:delcom
echo.
set /p del1=Click and drag or type in full location to the file : 
echo del %del1% >> %name%.bat


cls & goto nextcm
REM --RMDIR
:rmdircom
echo.
set /p rmdir1=Click and drag or type in full location to the folder : 
echo rmdir %rmdir1% >> %name%.bat


cls & goto nextcm
REM --MKDIR
:mkdircom
echo.
set /p mkdir1=Type in full location to new directory (Full path) : 
echo mkdir %mkdir1% >> %name%.bat


cls & goto nextcm
REM --TASKKILL
:taskkillcom
echo.
set /p taskkill1=Type in the name of the program to kill. (For ex: chrome.exe) : 
echo taskkill /f /im %taskkill1% >> %name%.bat

cls & goto nextcm
REM --START
:startcom
echo.
set /p start1=Click and drag a program or file to start: 
echo powershell start-process %start1% >> %name%.bat
cls & goto nextcm

REM ----------------



:goodbye

choice /c YN /M "Should it pause before exiting?"
If %ERRORLEVEL% equ 1 echo echo: >> %name%.bat & echo pause >> %name%.bat

echo.

choice /c YN /M "Should it be converted to exe (recommended)?"
If %ERRORLEVEL% equ 1 goto converttoexe

echo.
echo.
echo Goodbye :)
timeout 1 >nul
exit /b





REM -----CONVERTTOEXE

:converttoexe

;@echo off

;set "target.exe=%__cd__%%name%.exe"
;set "batch_file=%batdir%\%name%.bat"
;set "bat_name=%name%.bat"
;set "bat_dir=%batdir%"
;Set "sed=%temp%\2exe.sed"
;echo Please wait...  Creating "%name%.exe" ...
;copy /y "%~f0" "%sed%" >nul
;(
    ;(echo()
    ;(echo(AppLaunched=cmd /c "%bat_name%")
    ;(echo(TargetName=%target.exe%)
    ;(echo(FILE0="%bat_name%")
    ;(echo([SourceFiles])
    ;(echo(SourceFiles0=%bat_dir%)
    ;(echo([SourceFiles0])
    ;(echo(%%FILE0%%=)
;)>>"%sed%"

;iexpress /n /q /m %sed%
;del /q /f "%sed%"
;exit /b 0

[Version]
Class=IEXPRESS
SEDVersion=3
[Options]
PackagePurpose=InstallApp
ShowInstallProgramWindow=0
HideExtractAnimation=1
UseLongFileName=1
InsideCompressed=0
CAB_FixedSize=0
CAB_ResvCodeSigning=0
RebootMode=N
InstallPrompt=%InstallPrompt%
DisplayLicense=%DisplayLicense%
FinishMessage=%FinishMessage%
TargetName=%TargetName%
FriendlyName=%FriendlyName%
AppLaunched=%AppLaunched%
PostInstallCmd=%PostInstallCmd%
AdminQuietInstCmd=%AdminQuietInstCmd%
UserQuietInstCmd=%UserQuietInstCmd%
SourceFiles=SourceFiles

[Strings]
InstallPrompt=
DisplayLicense=
FinishMessage=
FriendlyName=-
PostInstallCmd=<None>
AdminQuietInstCmd=