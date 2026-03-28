@echo off
setlocal

REM Embry Labs — AI HTML Servers — Flask + Waitress (production WSGI)
REM Serves standalone HTML pages via waitress module.
REM   Port 8080 -> Embry Labs Homepage
REM   Port 5010 -> Future of AI Teams
REM   Port 5011 -> AI Tools - Current State
REM
REM Matches the Option 4 launch pattern:
REM   python -m waitress --host=HOST --port=PORT module:app

cd /d "%~dp0"

REM --- Activate local venv if present ---
if exist ".venv\Scripts\activate.bat" (
    call ".venv\Scripts\activate.bat"
)

REM --- Prefer bundled portable Python if present ---
set PYTHON_EXE=python
if exist "portable_python\python.exe" (
    set PYTHON_EXE=portable_python\python.exe
)

REM --- Verify Python is available ---
%PYTHON_EXE% --version >nul 2>&1
if errorlevel 1 (
    where python >nul 2>&1
    if errorlevel 1 (
        where py >nul 2>&1
        if errorlevel 1 (
            echo.
            echo [ERROR] Python not found. The bundled portable_python\python.exe should be present.
            echo         If it is missing, install Python 3.10+ or set PYTHON_EXE before running.
            pause
            exit /b 1
        ) else (
            set PYTHON_EXE=py
        )
    ) else (
        set PYTHON_EXE=python
    )
)

echo [OK] Using Python: %PYTHON_EXE%

REM --- Install waitress if not already installed ---
%PYTHON_EXE% -m pip show waitress >nul 2>&1
if errorlevel 1 (
    echo Installing waitress...
    %PYTHON_EXE% -m pip install waitress
)

REM --- Install app requirements if present ---
if exist "requirements.txt" (
    echo Installing requirements...
    %PYTHON_EXE% -m pip install -r requirements.txt
)

REM --- Server configuration ---
REM Change 0.0.0.0 to a specific IP if you need to bind to one interface only.
set HOST=0.0.0.0
set THREADS=8

echo.
echo =====================================================
echo  Starting Embry Labs Servers
echo  http://%HOST%:8080  -  Embry Labs Homepage
echo  http://%HOST%:5010  -  Future of AI Teams
echo  http://%HOST%:5011  -  AI Tools - Current State
echo =====================================================
echo.

start "Embry Labs Homepage [8080]" %PYTHON_EXE% -m waitress --host=%HOST% --port=8080 --threads=%THREADS% serve_homepage:app
timeout /t 1 /nobreak >nul
start "Future of AI Teams [5010]" %PYTHON_EXE% -m waitress --host=%HOST% --port=5010 --threads=%THREADS% serve_future_ai:app
timeout /t 1 /nobreak >nul
start "AI Tools - Current State [5011]" %PYTHON_EXE% -m waitress --host=%HOST% --port=5011 --threads=%THREADS% serve_ai_tools:app

echo  All servers started.
echo.
echo  To stop: close the server windows.
echo.

endlocal
