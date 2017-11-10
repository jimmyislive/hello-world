"""
This can be run via:
    gunicorn hello:app
"""
from hello import app

if __name__ == "__main__":
    app.run()
