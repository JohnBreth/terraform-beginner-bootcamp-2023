#!/usr/bin/env bash

# Define the alias
new_alias='alias tf="terraform"'

# Check if .bash_profile exists
if [ -f ~/.bash_profile ]; then
  # Check if the alias already exists in .bash_profile
  if grep -q "alias tf=\"terraform\"" ~/.bash_profile; then
    echo "Alias 'tf' for 'terraform' already exists in .bash_profile."
  else
    # Append the alias to .bash_profile
    echo "$new_alias" >> ~/.bash_profile
    echo "Alias 'tf' for 'terraform' added to .bash_profile."
  fi
else
  # .bash_profile doesn't exist, create it and add the alias
  touch ~/.bash_profile
  echo "$new_alias" >> ~/.bash_profile
  echo "Alias 'tf' for 'terraform' added to a new .bash_profile file."
fi

# Source .bash_profile to apply changes immediately
source ~/.bash_profile





