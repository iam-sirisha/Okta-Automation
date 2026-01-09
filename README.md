# Okta Deployments

## Setup Instructions

### 1. Update Package Repository and Upgrade Packages
```bash
sudo apt update
sudo apt upgrade
```

### 2. Install Python 3
```bash
sudo apt install python3
```

### 3. Install Python Package Manager (pip)
```bash
sudo apt install python3-pip
```

### 4. Install Additional Development Tools
```bash
sudo apt install python3-dev python3-venv build-essential
```

### 5. Configure Environment Variables
Set the required environment variables to fetch dev OKTA configs:

```bash
export OKTA_API_TOKEN="<token_here>"
export OKTA_DOMAIN="<domain_name>"
```

### 6. Execute Python Script
Run the Python script to fetch and deploy dev configurations:

```bash
python final_dev_till_auth_server.py
```