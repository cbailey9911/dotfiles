complete -C '/usr/local/bin/aws_completer' aws

get_aws_profile_parameter() {
  profile="${1?Please provide an AWS profile to configure.}"
  param="${2?Please provide a parameter to fetch.}"
  if ! aws configure --profile "$profile" get "$param" 2>/dev/null
  then
    >&2 echo "ERROR: Failed to retrieve [$param] for profile [$profile]."
  fi
}

load_aws_profile() {
  profile="${1?Please provide an AWS profile to configure.}"
  export AWS_ACCESS_KEY_ID=$(get_aws_profile_parameter "$profile" "aws_access_key_id") &&
  export AWS_SECRET_ACCESS_KEY=$(get_aws_profile_parameter "$profile" "aws_secret_access_key") &&
  export AWS_REGION=$(get_aws_profile_parameter "$profile" "region") &&
  export AWS_DEFAULT_REGION=$(get_aws_profile_parameter "$profile" "region");
  if [ "$profile" = "shared" ]; then
    export KITCHEN_SSH_KEY_NAME=$(get_aws_profile_parameter "$profile" "kitchen_ssh_key_name") &&
    export KITCHEN_SSH_KEY_PEM=$(get_aws_profile_parameter "$profile" "kitchen_ssh_key") &&
    export AWS_SUBNET=$(get_aws_profile_parameter "$profile" "aws_subnet") &&
    export AWS_OWNER_ID=$(get_aws_profile_parameter "$profile" "aws_owner_id") &&
    export VAULT_FILE=$(get_aws_profile_parameter "$profile" "vault_file")
  fi
}

>&2 echo "INFO: Loading AWS environt variables for the default profile."
>&2 echo "INFO: To change this, run 'load_aws_profile <your_profile>'."
load_aws_profile "default"
