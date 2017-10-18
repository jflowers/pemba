#!/usr/bin/env bash

export PYTHONDONTWRITEBYTECODE=true

export PYENV_TOOL_VERSION=1.1.5
export PYENV_ROOT="/usr/local/pyenv-$PYENV_TOOL_VERSION"
export PYTHON_VERSION="${PYTHON_VERSION:=2.7.14}"
export PYTHON_TYPE_NAME="pyenv"

export PYTHON_VIRTUALENV="${PYTHON_TYPE_NAME}-${PYTHON_VERSION}"

export PEMBA_PATHS_PYTHON_HOME="${PEMBA_PATHS_HOME}/python"

require 'env-vars/pipenv'

export PATHS_PROJECT_WORKSPACE_SETTINGS_PYTHON_HOME="${PATHS_PROJECT_WORKSPACE_SETTINGS_HOME}/python"
