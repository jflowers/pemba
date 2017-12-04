#!/usr/bin/env bash

require 'wrappers/pipenv'

export PEMBA_ANSIBLE_HOME="${PEMBA_PATHS_HOME}/ansible"

export PATHS_PROJECT_WORKSPACE_SETTINGS_ANSIBLE_HOME="${PATHS_PROJECT_WORKSPACE_SETTINGS_HOME}/ansible"
export PATHS_PROJECT_WORKSPACE_SETTINGS_ANSIBLE_MODULES_HOME="${PATHS_PROJECT_WORKSPACE_SETTINGS_ANSIBLE_HOME}/modules"

export PATHS_PROJECT_DEPLOY_ANSIBLE_HOME="${PATHS_PROJECT_DEPLOY_HOME}/ansible"
export PATHS_PROJECT_DEPLOY_ANSIBLE_MODULES_HOME="${PATHS_PROJECT_DEPLOY_ANSIBLE_HOME}/modules"
export PATHS_PROJECT_DEPLOY_ANSIBLE_ROLES_HOME="${PATHS_PROJECT_DEPLOY_ANSIBLE_HOME}/roles"

export PATHS_ORGANIZATION_ANSIBLE_GALAXY_HOME="${PATHS_ORGANIZATION_HOME}/.ansible_galaxy/${PROJECT_NAME}"
