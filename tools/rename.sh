#!/bin/bash

echo "🚀 Flutter Project Renamer"
echo ""

read -p "Enter new app name (e.g., Amino Therapy): " APP_NAME
read -p "Enter new package/bundle id (e.g., com.company.app): " BUNDLE_ID

dart run rename setAppName --value "$APP_NAME"
dart run rename setBundleId --value "$BUNDLE_ID"

echo ""
echo "✅ Done! Project renamed successfully"
