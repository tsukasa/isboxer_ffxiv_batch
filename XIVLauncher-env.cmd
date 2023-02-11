@echo off
rem ***************************************************************************
rem * XIVLauncher helper batch file for InnerSpace/ISBoxer                    *
rem *                                                                         *
rem * This file is used as a dummy in ISBoxer's file virtualization to easily *
rem * enable the use of multiple XIVLauncher data directories without having  *
rem * to manually configure multiple Inner Space profiles.                    *
rem ***************************************************************************

set CHARACTER_BATCH_FILENAME=%~nx0

for /F "tokens=3 delims=-" %%c in ("%~n0") do (
   set CHARACTER_ID=%%c
)

if "%CHARACTER_ID%" == "" ( goto :END_OF_FILE )

rem These settings control whether a different account should be used for
rem the command-line of XIVLauncher. Leave commented to disable.
rem Also note: The values for USE_OTP and USE_STEAM need to be either
rem True or False, not true or false. The accounts also need to be known
rem to XIVLauncher already.
rem set XIVLAUNCHER_ACCOUNT=MyAccountName
rem set XIVLAUNCHER_USE_OTP=True
rem set XIVLAUNCHER_USE_STEAM=True

set ROAMINGPATH_PRE=%ROAMINGPATH_ROOT%\%CHARACTER_ID%

:END_OF_FILE
