#!/usr/bin/env bash

require 'logging'
require 'wrappers/python'
require 'env-vars/pipenv'

function pipenv(){
  assert_set_env_is_up_to_date

  local pipenv_command=$1

  if [[ $pipenv_command == "install" || $pipenv_command == "package" || $pipenv_command == "update" ]]; then
    if [[ "$PATHS_PROJECT_WORKSPACE_SETTINGS_PIPENV_PIPFILE" -nt "$PATHS_PROJECT_PIPENV_INSTALL_FLAG_FILE" || "$PEMBA_PIPENV_PIPFILE" -nt "$PATHS_PROJECT_PIPENV_INSTALL_FLAG_FILE" ]]; then

      if [[ $pipenv_command == "update" ]]; then
        warn 'calling pipenv update, not sure yet if this is the right thing to do here'
        _pipenv update
      elif [[ "$PATHS_PROJECT_WORKSPACE_SETTINGS_PIPENV_PIPFILE" -nt "${PATHS_PROJECT_WORKSPACE_SETTINGS_PIPENV_PIPFILE}.lock" || "$PEMBA_PIPENV_PIPFILE" -nt "${PATHS_PROJECT_WORKSPACE_SETTINGS_PIPENV_PIPFILE}.lock" ]]; then
        warn 'calling pipenv lock, not sure yet if this is the right thing to do here'
        _pipenv lock
      else
        _pipenv install
      fi

      touch $PATHS_PROJECT_PIPENV_INSTALL_FLAG_FILE
      return 0
    else
      return 0
    fi
  fi

  eval "_pipenv ${*}"
  fail_if "Failed to execute: ${*}"
  return 0
}

function _pipenv(){
  _ensure_pipenv_installed

  cd $PATHS_PROJECT_WORKSPACE_SETTINGS_PIPENV_HOME

  debug "exec [$PIPENV_BIN ${*}] in [$PATHS_PROJECT_WORKSPACE_SETTINGS_PIPENV_HOME]"

  eval "$PIPENV_BIN ${*}" 1>&2
  local pipenv_exit_code=$?

  cd $OLDPWD
  fail_if "Failed to execute: [$PIPENV_BIN ${*}] in [$PATHS_PROJECT_WORKSPACE_SETTINGS_PIPENV_HOME]" $pipenv_exit_code

  python__rehash
}

function _ensure_pipenv_installed(){
  if [[ ! $(which pipenv) ]]; then
    pip install pipenv
    fail_if "failed to install pipenv pip"
  fi
  if [[ -z "$PIPENV_BIN" ]]; then
    export PIPENV_BIN="$(which pipenv)"
  fi
}
