#!/usr/bin/env bash

require 'baseline/package'

function baseline__python__up_to_date_q(){
  require 'wrappers/python'

  if ! python__load_shell ; then
    set_baseline_up_to_date_override

    register_baseline_installer_function baseline__python__install_python

    return 0
  fi
}

function baseline__python__ensure_installed() {
  local github_project=$1
  local project_version=$2

  if [[ $(type "${github_project}") ]]; then
    return 0
  fi

  cd "${TMPDIR}"

    wget "https://github.com/pyenv/${github_project}/archive/v${project_version}.zip"
    local exit_code=$?
    fail_if "failed to wget archive for ${github_project} ${project_version}" $exit_code "$OLDPWD"

    unzip "v${project_version}.zip"
    local exit_code=$?
    fail_if "failed to unzip archive for ${github_project} ${project_version}" $exit_code "$OLDPWD"

    sudo__execute_with_administrator_privileges mv "${github_project}-${project_version}" /usr/local/
    local exit_code=$?
    fail_if "failed to move folder for ${github_project} ${project_version}" $exit_code "$OLDPWD"

    rm -f "${project_version}.zip"
    local exit_code=$?
    fail_if "failed to delete zip for ${github_project} ${project_version}" $exit_code "$OLDPWD"

  cd $OLDPWD

  for binary in "/usr/local/${github_project}-${project_version}/bin"/* ; do
    ln -s "${binary}" /usr/local/bin/
    fail_if "failed to create symbolic link for ${binary}"
  done
}

function baseline__python__install_python() {
  if [[ ! $(which wget) ]]; then
    baseline__package__command install wget
  fi

  baseline__python__ensure_installed 'pyenv' $PYENV_TOOL_VERSION
  baseline__python__ensure_installed 'pyenv-virtualenv' '1.1.1'

  python__init

  pyenv install "$PYTHON_VERSION"
  fail_if "failed to install python $PYTHON_VERSION"

  python__load_shell
  fail_if "failed to load pyenv shell"
}


if [[ -n "$AUTO_BOOTSTRAP" && $AUTO_BOOTSTRAP == true ]]; then
  register_baseline_up_to_date_function baseline__python__up_to_date_q
fi
