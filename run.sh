#!/bin/bash

if [[ "$1" == "build" ]]; then
  cd ./web
  npm run release
  cd ..
  sh ./scripts/build.sh
elif [[ "$1" == "serve" ]]; then
  mkdir -p ./data
  # https://www.usememos.com/docs/install/runtime-options
  ./build/memos --mode prod --data "$(pwd)/data" --port 8081
elif [[ "$1" == "backup" ]]; then
  mkdir -p ./backup
  BACKUP_FILE="memos-UTC-$(TZ=UTC date +%Y%m%d_%H%M%S).zip"
  zip -r "./backup/$BACKUP_FILE" ./data
elif [[ "$1" == "mv-backup" ]]; then
  if [[ -z "$2" ]]; then
    echo "Error: Please provide a target folder name."
    exit 1
  fi
  if [[ ! -d "$2" ]]; then
    echo "Error: Target folder '$2' does not exist."
    exit 1
  fi
  mv ./backup/* "$2"/
else
  echo "Usage: $0 {build|serve}"
fi