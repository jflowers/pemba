#!/usr/bin/env bash

require 'env-vars/ansible'

function ansible__configure_workspace(){
  pipenv 'install'

  cd "${PATHS_PROJECT_WORKSPACE_SETTINGS_ANSIBLE_HOME}"

    echo ""
    echo "$(colorize -t $LIGHT_CYAN 'beginning workspace configuration with ansible, admin privilages required, you may be prompted...')"
    echo ""

    export VALIDATE_INTEGRITY=false

    ANSIBLE_LIBRARY="${PATHS_PROJECT_WORKSPACE_SETTINGS_ANSIBLE_MODULES_HOME}" ansible-playbook playbook.yml -i "${PEMBA_ANSIBLE_HOME}/hosts" -K
    local exit_code=$?
    if [[ $exit_code == 0 ]]; then
      set_integrity
      export VALIDATE_INTEGRITY=true
    fi

  cd $OLDPWD

  rename_terminal

  fail_if "failed to configure workspace" $exit_code
}
