#!/bin/bash
export FLASK_DEBUG=1
# FLASK_APP=app.py pipenv run python -m flask run
pipenv run python -m flask run --host=0.0.0.0