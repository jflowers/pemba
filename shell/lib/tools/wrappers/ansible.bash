#!/usr/bin/env bash

require 'env-vars/ansible'

function ansible(){
  _ansible "${*}"
}

function _ansible(){
  pipenv 'install'

  cd "${PEMBA_ANSIBLE_HOME}"

    "${ANSIBLE_BIN}" "${*}"
    local exit_code=$?

  cd $OLDPWD

  rename_terminal

  fail_if "failed to execute: ansible ${*}" $exit_code
}

function ansible__configure_workspace(){
  pipenv 'install'

  cd "${PEMBA_ANSIBLE_HOME}"

    echo ""
    echo "$(colorize -t $LIGHT_CYAN 'beginning workspace configuration with ansible, admin privilages required, you may be prompted...')"
    echo ""

    export VALIDATE_INTEGRITY=false

    sudo__execute_with_administrator_privileges "${ANSIBLE_PLAYBOOK_BIN}" playbook.yml -i "${PEMBA_ANSIBLE_HOME}/hosts"
    local exit_code=$?
    if [[ $exit_code == 0 ]]; then
      set_integrity
      export VALIDATE_INTEGRITY=true
    fi

  cd $OLDPWD

  rename_terminal

  fail_if "failed to configure workspace" $exit_code
}
