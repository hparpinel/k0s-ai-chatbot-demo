# k0s Chatbot Demo

This project demonstrates how to deploy a simple GPT-2-powered chatbot using [Mirantis k0s](https://k0sproject.io), a lightweight and developer-friendly Kubernetes distribution.

## Project Structure

```bash
k0s-ai-chatbot-demo
├── k0s-demo # Main application and Kubernetes manifests
│    ├── app
│    │    ├── backend # Flask backend with GPT-2 model
│    │    └── frontend # Simple HTML frontend for user interaction
│    └── k8s # Kubernetes deployment and service YAMLs
│
├── docs # GitHub Pages blog or documentation
│    └── index.md # Technical blog post about the demo
│
└── scripts
     └── install-dependencies.sh # Script to install tools needed to build and run the demo
```

## Install Dependencies

To quickly set up the environment on **Ubuntu Linux**, you can use the provided setup script:

```bash
cd scripts
chmod +x install-dependencies.sh
./install-dependencies.sh

```

### What the script does:

* Installs and initializes k0s, including creating a single-node cluster

* Installs and starts Docker

* Installs Python 3, pip, and required Python packages:

* flask, transformers, and torch

* Optionally installs Visual Studio Code (via Snap, if not already installed)

* Adds your user to the Docker group (you may need to log out and back in)

**Note:** This script is meant for Ubuntu systems and should be run with sudo privileges where required.

## Usage

See [docs/index.md](docs/index.md) for the full walkthrough, including setup, deployment, and production scaling using k0s.

## Requirements

- Docker
- Python 3
- Ubuntu Linux (tested)
- k0s CLI

---
