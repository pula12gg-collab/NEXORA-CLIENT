@echo off
set APP_HOME=%~dp0
if exist "%APP_HOME%gradle\wrapper\gradle-wrapper.jar" (
  java -classpath "%APP_HOME%gradle\wrapper\gradle-wrapper.jar" org.gradle.wrapper.GradleWrapperMain %*
  exit /b %ERRORLEVEL%
)
where gradle >nul 2>nul
if %ERRORLEVEL% EQU 0 (
  cd /d "%APP_HOME%"
  gradle wrapper --gradle-version 8.14.3
  if %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%
  call "%APP_HOME%gradlew.bat" %*
  exit /b %ERRORLEVEL%
)
echo NEXORA: gradle-wrapper.jar is missing and Gradle is not installed.
echo Install Gradle 8.14+ or run gradle wrapper --gradle-version 8.14.3, then retry.
exit /b 1
