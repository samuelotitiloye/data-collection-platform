#!/bin/bash
# Usage: source ./assume-gha-role.sh
# Assumes the GitHub Actions role and exports temporary credentials

ROLE_ARN="arn:aws:iam::771936570821:role/data-collection-platform-dev-gha-deploy"
SESSION_NAME="gha-cli-session"

# Call assume-role and capture JSON output
CREDS_JSON=$(aws sts assume-role \
    --role-arn "$ROLE_ARN" \
    --role-session-name "$SESSION_NAME")

# Export environment variables
export AWS_ACCESS_KEY_ID=$(echo $CREDS_JSON | jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(echo $CREDS_JSON | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo $CREDS_JSON | jq -r '.Credentials.SessionToken')

echo "Temporary AWS credentials exported. Valid until $(echo $CREDS_JSON | jq -r '.Credentials.Expiration')"
