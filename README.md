# Docker Registry Cleanup Script

This script automates the cleanup of old images from a private Docker registry while preserving the latest tags. It uses [andrey-pohilko/registry-cli](https://github.com/andrey-pohilko/registry-cli) to perform the cleanup operations and integrates with 1Password for secure credential management.

## Prerequisites

- Docker installed
- 1Password CLI (`op`) installed and configured

## Setup

1. Copy the environment file template to create your configuration:

```bash
mv .env.replace .env
```

2. Edit `.env` with your specific values:

```properties
PASSWORD_VAULT="your_1password_vault_name"
ITEM_NAME="your_1password_item_name"
USERNAME_FIELD="field_name_for_username"
PASSWORD_FIELD="field_name_for_password"
REGISTRY_URL="https://your.registry.url"
```

## Usage

```bash
./cleanup-registry.sh
```
