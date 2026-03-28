AI HTML Servers — Deploy Package
=================================
GR Label | March 2026

CONTENTS
---------
  START.bat              Start both HTML servers (self-checking, auto-installs)
  serve_future_ai.py     Waitress server — Future of AI Teams    (port 5010)
  serve_ai_tools.py      Waitress server — AI Tools Current State (port 5011)
  requirements.txt       Python dependencies (flask, waitress)
  portable_python\       Bundled Python 3.11 runtime (no install required)
  html\                  HTML report files
  assets\                Images and supporting files

QUICK START
-----------
  1. Double-click START.bat

     That's it. START.bat will:
       - Detect Python automatically (uses bundled portable_python\ first)
       - Check and install waitress if missing
       - Install requirements.txt if needed
       - Launch both servers in separate windows
       - Open both browser tabs automatically:
           Future of AI Teams      ->  http://localhost:5010
           AI Tools (Safe Use)     ->  http://localhost:5011

  2. To stop the servers: close the two black server windows.

PYTHON RESOLUTION ORDER
-----------------------
  START.bat finds Python in this order:
    1. PORTABLE_PYTHON environment variable (if set)
    2. portable_python\python.exe  (bundled — preferred, no install needed)
    3. System 'python'
    4. System 'py'
    5. Error with instructions

  If the bundled portable_python is present you do NOT need Python installed.

NETWORK ACCESS
--------------
  The servers bind to 0.0.0.0 — other computers on the same network
  can reach them using your IP address:
    http://<your-ip>:5010
    http://<your-ip>:5011

  Find your IP:  Open Command Prompt -> type: ipconfig

NOTES
-----
  - Waitress is a production-grade WSGI server (not Flask dev mode)
  - Each server runs in its own window — closing the window stops that server
  - Both servers are independent; you can run either one alone
  - No browser zone/JavaScript policy issues — served via HTTP, not UNC path
