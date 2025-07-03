@echo off

set "INCLUDE=%LIBRARY_INC%;%LIBRARY_INC%\GL;%INCLUDE%"
set "LIB=%LIBRARY_LIB%;%LIB%"

cd /d "%SRC_DIR%\src"

cl /c /DWIN32 /DOPENGL_10=1 /I"GL" /I"%LIBRARY_INC%" /I"%LIBRARY_INC%\GL" *.c

if %ERRORLEVEL% neq 0 (
    echo Compilation failed!
    exit /b %ERRORLEVEL%
)

lib /out:gle.lib *.obj

if %ERRORLEVEL% neq 0 (
    echo Library creation failed!
    exit /b %ERRORLEVEL%
)

copy gle.lib "%LIBRARY_LIB%\"

if not exist "%LIBRARY_INC%\gle" mkdir "%LIBRARY_INC%\gle"
copy "..\src\*.h" "%LIBRARY_INC%\gle\"

del *.obj