#!/usr/bin/env bash

require 'logging'
require 'wrappers/python'
require 'env-vars/pipenv'

function pipenv(){
  assert_set_env_is_up_to_date

  _ensure_pipenv_installed

  local pipenv_command=$1

  if [[ $pipenv_command == "install" || $pipenv_command == "package" || $pipenv_command == "update" ]]; then
    if [[ "$PIPENV_GEMFILE" -nt "$PATHS_PROJECT_PIPENV_INSTALL_FLAG_FILE" || "$PEMBA_PIPENV_GEMFILE" -nt "$PATHS_PROJECT_PIPENV_INSTALL_FLAG_FILE" ]]; then

      case $OS_NAME in
        Darwin)
          _pipenv config build.nokogiri --with-xml2-include=/usr/local/Cellar/libxml2/2.9.4/include/libxml2/libxml --with-xml2-lib=/usr/local/Cellar/libxml2/2.9.4/lib --with-xslt-dir=/usr/local/Cellar/libxslt/1.1.28_1
          ;;
        *)
          _pipenv config build.nokogiri --use-system-libraries
          ;;
      esac

      if [[ $pipenv_command == "update" ]]; then
        _pipenv update
      elif [[ "$PIPENV_GEMFILE" -nt "${PIPENV_GEMFILE}.lock" || "$PEMBA_PIPENV_GEMFILE" -nt "${PIPENV_GEMFILE}.lock" ]]; then
        _pipenv package
      else
        _pipenv install --local
      fi

      touch $PATHS_PROJECT_PIPENV_INSTALL_FLAG_FILE
      return 0
    else
      return 0
    fi
  fi

  eval "$RUBY_BIN $PIPENV_BIN ${*}"
  fail_if "Failed to execute: ${*}"
  return 0
}

function _pipenv(){
  cd $PATHS_PROJECT_WORKSPACE_SETTINGS_PIPENV_HOME

  debug "exec [RUBYOPT='' PIPENV_BIN_PATH='' $RUBY_BIN $PIPENV_BIN ${*}] in [$PATHS_PROJECT_WORKSPACE_SETTINGS_PIPENV_HOME]"

  eval "RUBYOPT='' PIPENV_BIN_PATH='' $RUBY_BIN $PIPENV_BIN ${*}" 1>&2
  local pipenv_exit_code=$?

  cd $OLDPWD
  fail_if "Failed to execute: [pipenv ${*}] in [$PATHS_PROJECT_WORKSPACE_SETTINGS_PIPENV_HOME]" $pipenv_exit_code

  ruby__rehash
}

function _ensure_pipenv_installed(){
  if [[ ! -d "$GEM_HOME/gems/pipenv-${PIPENV_VERSION}" ]]; then
    RUBYOPT='' PIPENV_BIN_PATH='' gem install --local "${PEMBA_PIPENV_HOME}/pipenv-${PIPENV_VERSION}.gem"
    fail_if "failed to install pipenv gem"
  fi
}

function gem_bin_path() {
  pipenv install --local

  RUBYOPT='' $RUBY_BIN -e "puts Gem.bin_path('$1', '$2')"
  fail_if "failed to find gem bin path for $1 $2"
}
