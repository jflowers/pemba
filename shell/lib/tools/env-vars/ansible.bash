#!/usr/bin/env bash

require 'wrappers/pipenv'

export PEMBA_ANSIBLE_HOME="${PEMBA_PATHS_HOME}/ansible"

export PATHS_PROJECT_WORKSPACE_SETTINGS_ANSIBLE_HOME="${PATHS_PROJECT_WORKSPACE_SETTINGS_HOME}/ansible"
export PATHS_PROJECT_WORKSPACE_SETTINGS_ANSIBLE_MODULE_HOME="${PATHS_PROJECT_WORKSPACE_SETTINGS_ANSIBLE_HOME}/module"

export ANSIBLE_LIBRARY="${PATHS_PROJECT_WORKSPACE_SETTINGS_ANSIBLE_MODULE_HOME}"
