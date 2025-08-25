#!/bin/bash

ENV_FILE="${DOTFILES_DIR}/.env.local"
> "$ENV_FILE"

{
  echo "# Environment variables from 1Password"
  echo "# Generated on $(date)"
  echo ""

  # Get individual fields from GitHub item
  GHCR_TOKEN="$(op item get --vault FirstAm Github_Firstam --fields GHCR_PAT --reveal 2>/dev/null)"
  GIT_AUTHOR_NAME="$(op item get --vault FirstAm Github_Firstam --fields AuthorName --reveal 2>/dev/null)"
  GIT_AUTHOR_EMAIL="$(op item get --vault FirstAm Github_Firstam --fields AuthorEmail --reveal 2>/dev/null)"
  
  if [[ -n "$GHCR_TOKEN" ]]; then
    echo "HOMEBREW_GITHUB_API_TOKEN=\"$GHCR_TOKEN\""
    echo "GH_TOKEN=\"$GHCR_TOKEN\""
  fi
  
  if [[ -n "$GIT_AUTHOR_NAME" ]]; then
    echo "GIT_AUTHOR_NAME=\"$GIT_AUTHOR_NAME\""
  fi
  
  if [[ -n "$GIT_AUTHOR_EMAIL" ]]; then
    echo "GIT_AUTHOR_EMAIL=\"$GIT_AUTHOR_EMAIL\""
  fi

  # Get DigitalOcean API key
  DO_API_KEY="$(op item get --vault Private Digitalocean_Personal --fields DO_API_KEY --reveal 2>/dev/null)"
  if [[ -n "$DO_API_KEY" ]]; then
    echo "DO_API_KEY=\"$DO_API_KEY\""
  fi
  
} >> "$ENV_FILE"

echo "Environment variables written to: $ENV_FILE"

# Set secure permissions on the file
chmod 600 "$ENV_FILE"