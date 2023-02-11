@echo off
rem ***************************************************************************
rem *                                                                         *
rem * XIVLauncher Helper Batch File for Inner Space/ISBoxer                   *
rem *                                                                         *
rem ***************************************************************************

rem ***************************************************************************
rem * C O N F I G U R A T I O N                                               *
rem ***************************************************************************

rem Skip XIVLauncher update check? [true/false, default: false]
rem Setting this to "true" will also change the XIVLauncher window title to
rem contain "UNSUPPORTED VERSION - NO UPDATES - COULD DO BAD THINGS".
rem set XL_NOAUTOUPDATE=true

rem ISDalamudUpdater location [real path, default: commented out]
rem Comment the line via REM to disable.
set ISDU_ROOT=G:\Multiboxing\ISDalamudUpdater

rem Root location of the XIVLauncher executables [real path, default: %LOCALAPPDATA%\XIVLauncher]
rem This only needs adjustment in case you are using a self-compiled
rem build of XIVLauncher.
set XIVLAUNCHER_LOCALDATA=%LOCALAPPDATA%\XIVLauncher

rem Default data location [real path, default: "%APPDATA%\XIVLauncher"]
set ROAMINGPATH="%APPDATA%\XIVLauncher"

rem Root directory for character/characterset-specific data [real path]
set ROAMINGPATH_ROOT=G:\Multiboxing\XIVLauncherData


rem *** You should not have to change anything below this point.
rem *** Thank you for flying Air Eorzea!


rem ***************************************************************************
rem * P R O C E S S I N G                                                     *
rem ***************************************************************************

rem --- Pre-checks ------------------------------------------------------------
if not exist "%XIVLAUNCHER_LOCALDATA%" (
  echo Error: XIVLauncher not found in "%XIVLAUNCHER_LOCALDATA%".
  pause
  goto :END_OF_FILE
)

rem --- Check character virtualization ----------------------------------------
rem Query whether we are using a virtualized file
call "%~dp0%\XIVLauncher-env.cmd"

rem In case we are launching the XIVLauncher.cmd normally with virtualization
rem of XIVLauncher-env.cmd, the ROAMINGPATH_PRE variable should be filled with
rem the full path to the character-specific ROAMINGPATH.
if not "%ROAMINGPATH_PRE%" == "" (
  set ROAMINGPATH=%ROAMINGPATH_PRE%
)

echo Will be using this directory as roamingPath: %ROAMINGPATH%

rem --- Set-up --account parameter --------------------------------------------
rem To use this feature, you need to log-in at least once with the account
rem you wish to preselect in XIVLauncher.
rem Edit the XIVLauncher-env-CHARACTER.cmd accordingly to activate!
if not "%XIVLAUNCHER_ACCOUNT%" == "" (
  set XIVLAUNCHER_ACCOUNT_ARG=--account="%XIVLAUNCHER_ACCOUNT%-%XIVLAUNCHER_USE_OTP%-%XIVLAUNCHER_USE_STEAM%"
  echo.
  echo Setting XIVLauncher account name to: %XIVLAUNCHER_ACCOUNT% [Use OTP: %XIVLAUNCHER_USE_OTP%, Is Steam: %XIVLAUNCHER_USE_STEAM%]
)

rem --- Automatic Dalamud update ----------------------------------------------
rem If available, we will try to update Dalamud before launching.
rem This should not be required as Dalamud automatically gets
rem updated during the startup procedure of XIVLauncher.
if defined ISDU_ROOT (
  if exist "%ISDU_ROOT%" (
    echo.
    echo Updating Dalamud...
    call "%ISDU_ROOT%\ISDalamudUpdater.exe" --roamingPath="%ROAMINGPATH%"
  )
)

rem --- Start XIVLauncher -----------------------------------------------------
echo Launching XIVLauncher...
start "XIV Launcher" "%XIVLAUNCHER_LOCALDATA%\XIVLauncher.exe" --roamingPath="%ROAMINGPATH%" %XIVLAUNCHER_ACCOUNT_ARG% %*
exit 0
:END_OF_FILE
