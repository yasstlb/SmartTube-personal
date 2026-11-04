@echo off
setlocal
cd /d "%~dp0"
echo Checking Android build prerequisites...
where java >nul 2>nul
if errorlevel 1 (
 echo ERROR: Java JDK not found on PATH. SmartTube requires a compatible JDK ^(upstream recommends JDK 14 or earlier^).
 exit /b 1
)
if not defined ANDROID_HOME if not defined ANDROID_SDK_ROOT (
 echo WARNING: ANDROID_HOME or ANDROID_SDK_ROOT is not set. Gradle may require a configured Android SDK.
)
if not exist "SharedModules\core_settings.gradle" (
 echo ERROR: Git submodules missing. Run: git submodule update --init --recursive
 exit /b 1
)
if not exist "MediaServiceCore\core_settings.gradle" (
 echo ERROR: Git submodules missing. Run: git submodule update --init --recursive
 exit /b 1
)
echo Building stable debug APK locally. This does not use GitHub Actions.
call "%~dp0gradlew.bat" --no-daemon :smarttubetv:assembleStstableDebug
if errorlevel 1 (
 echo ERROR: Gradle build failed. Review the output above.
 exit /b 1
)
echo.
echo Build completed. Check smarttubetv\build\outputs\apk\ststable\debug\
exit /b 0
