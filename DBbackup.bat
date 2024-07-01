@echo off
setlocal

:: Prompt the user to enter database connection details
echo *****Please Enter The Database Connection Details Which You Want To Backup*****
echo.
set /p dbHost=Enter host (e.g., localhost):
set /p dbPort=Enter port (e.g., 3306):
set /p dbUser=Enter username (e.g., root):
set /p dbPassword=Enter password:
set /p dbName=Enter database name:
echo. 

:: Get the current date in YYYYMMDD format
for /f "tokens=1-3 delims=/" %%a in ('echo %date%') do (
    set "currentDate=%%c%%a%%b"
)

:: Prompt the user to enter the backup time
echo *****When do you want to take the backup*****
echo.
set /p hour=Enter hour (24-hour format, e.g., 13 for 1 PM): 
set /p minute=Enter minute (e.g., 30): 

:: Calculate the delay in seconds from the current time to the scheduled backup time
for /f "tokens=1-3 delims=:." %%a in ("%time%") do (
    set /a currentHour=%%a
    set /a currentMinute=%%b
    set /a currentSecond=%%c
)
set /a delayHour=%hour% - %currentHour%
set /a delayMinute=%minute% - %currentMinute%

:: Adjust delay for negative values
if %delayMinute% lss 0 (
    set /a delayMinute+=60
    set /a delayHour-=1
)
if %delayHour% lss 0 (
    set /a delayHour+=24
)

set /a delayInSeconds=%delayHour%*3600 + %delayMinute%*60 - %currentSecond%

:: Notify the user about the scheduled backup time
echo.
echo Scheduled backup at %hour%:%minute%. 
echo.

:: Display the ASCII art banner from the file in the current directory
type "%~dp0banner.txt"
echo.
:: Notify the user that the terminal will close
echo Minimize The Terminal Now!
echo.
:: Notify the user Successful Backup
echo You Will Get Notification After Successful Backup!

:: Close the terminal after a delay
set /a remainingDelay=%delayInSeconds%
:DELAY_LOOP
if %remainingDelay% gtr 0 (
    timeout /t 1 >nul
    set /a remainingDelay-=1
    goto :DELAY_LOOP
)

:: Construct the backup file name with hour, minute, and date in the DBbackup folder
set "backupFileName=%~dp0DBbackup\backup_%hour%_%minute%_%currentDate%.sql"

:: Start the backup process in the background
echo.
start /b "" cmd /c "mysqldump -h %dbHost% -P %dbPort% -u %dbUser% -p%dbPassword% %dbName% > "%backupFileName%""

:: Wait for the backup process to complete
timeout /t 5 >nul

:: Display a popup message using msg command
msg * "Database backup completed successfully!"

endlocal
