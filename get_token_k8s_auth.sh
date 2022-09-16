#!usr/bin/env bash

# The script uses Kubernetes authentication method in HashiCorp Vault to log in
# and return a session token
#
# Requirements:
#
# The script requires ENV variables to be set:
#
# VAULT_ADDR      URI of the HashiCorp Vault (example: https://vault_address:8200)
# VAULT_ROLE      role for authentication
# K8S_AUTH_PATH   path of authentication method
#

SA_TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)

RESPONSE=$(curl -L --request POST --data-raw "{\"jwt\":\"${SA_TOKEN}\", \"role\":\"${VAULT_ROLE}\"}" ${VAULT_ADDR}/v1/auth/${K8S_AUTH_PATH}/login)

CLIENT_TOKEN=$(echo "${RESPONSE}" | jq -r .auth.client_token)

echo "${CLIENT_TOKEN}"

exit 0

