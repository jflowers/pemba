#!/usr/bin/env bash

require 'env-vars/shovel'
require 'wrappers/pipenv'

function shovel(){
  _shovel "${*}"
}

function _shovel(){
  pipenv 'install'

  cd "${PEMBA_PATHS_SHOVEL_HOME}"

    python "${PEMBA_PATHS_PYTHON_HOME}/shovel/bin/shovel" "${*}"
    local exit_code=$?

  cd $OLDPWD

  rename_terminal

  fail_if "failed to execute: shovel ${*}" $exit_code
}
