#!/usr/bin/env bash

require 'baseline/python'

function baseline__pipenv__up_to_date_q(){
  require 'env-vars/pipenv'
  if [[ ! -e "$PATHS_PROJECT_PIPENV_INSTALL_FLAG_FILE" ]]; then
    set_baseline_up_to_date_override

    register_baseline_installer_function baseline__pipenv__install_pipenv

    return 0
  fi
}

function baseline__pipenv__install_pipenv() {
  warn 'pipenv baseline install needs implementation!!!'
  # require 'wrappers/pipenv'
  # pipenv 'install' '--local'
}


if [[ -n "$AUTO_BOOTSTRAP" && $AUTO_BOOTSTRAP == true ]]; then
  register_baseline_up_to_date_function baseline__pipenv__up_to_date_q
fi
