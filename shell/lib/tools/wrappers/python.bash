#!/usr/bin/env bash

require 'env-vars/python'
require 'wrappers/pipenv'

function python(){
	pipenv 'install' '--local'

  $PYTHON_BIN "$@"
  fail_if "Failed to execute: python ${*}"

  rename_terminal
}

function python__init() {
  type pyenv 2>&1 1>/dev/null || return 1

  eval "$(pyenv init - )"
  fail_if "unable to initialize pyenv"
}

function python__load_shell() {
  python__init || return 1

  local python_instalations=($(pyenv versions))

  contains 'python_instalations' "$PYTHON_VERSION" || return 1

  pyenv shell $PYTHON_VERSION
  fail_if "unable set python version with pyenv"

  export PYTHON_BIN=$(which python)
  return 0
}

function python__rehash() {
  pyenv rehash
}

python__load_shell

function python__add_pemba_gems_to_path() {
  for dir in $(find "${PEMBA_PATHS_PYTHON_HOME}" -name bin -type d) ; do
    export PATH="$dir:$PATH"
  done
}
python__add_pemba_gems_to_path

function python__add_workspace_gems_to_path() {
	if [[ -e "${PATHS_PROJECT_WORKSPACE_SETTINGS_PYTHON_HOME}" ]]; then
	  for dir in $(find "${PATHS_PROJECT_WORKSPACE_SETTINGS_PYTHON_HOME}" -name bin -type d) ; do
	    export PATH="$dir:$PATH"
	  done
	fi
}
python__add_workspace_gems_to_path
