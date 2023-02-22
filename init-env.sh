#!/bin/bash

ROOT_PASSWORD="{root password of mysql}"
DATABASE="{database of keycloak}"
MYSQL_USER="{database username}"
MYSQL_PASSWORD="{database password}"

KEYCLOAK_USER="{keycloak admin user}"
KEYCLOAK_PASSWORD="{keycloak admin password}"

cat .env.tpl | \
  sed "s|{root password of mysql}|${ROOT_PASSWORD}|" | \
  sed "s|{database of keycloak}|${DATABASE}|" | \
  sed "s|{database username}|${MYSQL_USER}|" | \
  sed "s|{database password}|${MYSQL_PASSWORD}|" | \
  sed "s|{keycloak admin user}|${KEYCLOAK_USER}|" | \
  sed "s|{keycloak admin password}|${KEYCLOAK_PASSWORD}|" 


