#!/bin/zsh

# Install dependencies
pipenv install
if [[ $? -ne 0 ]]; then
    echo "Failed to install dependencies."
    exit 1
fi

# Set Flask environment variables
export FLASK_APP=app.py
export FLASK_RUN_PORT=5555

# Run commands within the Pipenv environment
pipenv run flask db upgrade
if [[ $? -ne 0 ]]; then
    echo "Failed to upgrade the database."
    exit 1
fi

pipenv run python seed.py
if [[ $? -ne 0 ]]; then
    echo "Failed to seed the database."
    exit 1
fi

pipenv run python app.py
