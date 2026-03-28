# ============================================================
# Future of AI Teams -- Flask app
# Launched via:  python -m waitress --host=H --port=P serve_future_ai:app
# ============================================================
import os
from flask import Flask, send_from_directory

BASE   = os.path.dirname(os.path.abspath(__file__))
HTML   = os.path.join(BASE, 'html')
ASSETS = os.path.join(BASE, 'assets')

app = Flask(__name__)

@app.route('/')
def index():
    return send_from_directory(HTML, 'Future of AI Teams.html')

@app.route('/assets/<path:filename>')
def assets(filename):
    return send_from_directory(ASSETS, filename)

