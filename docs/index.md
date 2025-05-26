# From Zero to AI: Kubernetes the k0s Way

## A Developer's Journey from Local Testing to Production-Ready Deployment

![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
[![Mirantis](https://img.shields.io/badge/Mirantis-00A0DF?style=for-the-badge&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAEbSURBVHgBjVLBUQJBEOxdVeAfPwY4IxAjECIQIxAiECIQI1AiECNQIhAiECO4O34A/mG6b3YP9o7T41V1xc3OTk9Pz+wRZnYAJd/3n0Mk+r5/xzwP2rZdwbdAG5gEQTDEaIQ6g3+Bf9M0xYM+53mes1D4hb7CfY0IhNNneIvhBrwAP3Ec5+AHcACP1oL5Bf1lWRYg6qCu63J4VVVloO87NE0zEs4wkqZpgZEi8MZQxcm+qMhbRB1Ls6y1EwE0P0Nn2AoE5RwRQy2/Q4K4YF0PxJBlWQEfW4H4lRAhRFEUYqQCPxCAZyYS+QvYm6ZpAv/WQRA84QMN+hY+w0cUx/FCBHAqMk6Sj4LHWZZ9EfEGPsEFzn/Bv9AX9h9YYnMVEF5M4wAAAABJRU5ErkJggg==)](https://www.mirantis.com/software/k0s)

## Table of Contents
- [Overview](#overview)
- [Why k0s?](#why-k0s)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Project Overview](#project-overview)
- [Local Testing](#local-testing)
- [Deploying with k0s](#deploying-with-k0s)
- [Enterprise Scaling](#enterprise-scaling)
- [Project Layout](#project-layout)
- [Next Steps](#next-steps)

## Overview

What if you could go from a blank machine to a running AI application on Kubernetes, in minutes?

In this walkthrough, I demonstrate how **Mirantis k0s**,  a production-grade Kubernetes distribution, enables developers and teams to rapidly deploy containerized AI applications. With k0s's zero-friction approach, you can move from local testing to production deployment with confidence.

Whether you're testing AI models, building microservices, or scaling enterprise applications, this project shows how k0s eliminates complexity while maintaining production-ready features.

---

## Demo Video

Watch the full demo of this project in action:

[![Watch on YouTube](https://img.youtube.com/vi/1C_xF7l513A/hqdefault.jpg)](https://youtu.be/1C_xF7l513A)

## Why k0s?

k0s, backed by Mirantis's enterprise expertise, delivers:

* **Zero Friction**: Single binary that includes everything you need
* **Zero Dependencies**: No external requirements or complex setups
* **Enterprise Ready**: CNCF-certified with production-grade features
* **Developer Friendly**: Perfect for local dev, CI/CD, and production

Ideal for organizations that want to standardize their Kubernetes strategy across all environments while maintaining simplicity.

---

## Prerequisites

To follow this demo, you'll need:

* Docker
* Python 3
* k0s CLI ([Download from Mirantis](https://k0sproject.io/))

This demo was tested on **Ubuntu Linux**. Other Linux distributions may work, but results may vary.

---

## Getting Started

First, clone this repository and navigate to the project directory:

```bash
git clone https://github.com/hparpinel/k0s-ai-chatbot-demo.git
cd k0s-demo
```

---

## Project Overview

This demo app includes:

* **Modern Frontend**: A simple HTML/JS interface to submit prompts
* **AI Backend**: Flask API using Hugging Face's GPT-2 model
* **Container Strategy**: Production-ready Docker configuration
* **Orchestration**: k0s Kubernetes with zero friction
* **Flexible Deployment**: Local testing to production scaling

---

## Local Testing

> **Pro Tip:** k0s's lightweight footprint means you can run production-identical environments locally, ensuring consistency across your pipeline.

Test the containerized application:

```bash
# # Build and run container locally
docker build -t ai-chatbot -f app/backend/Dockerfile .
docker run -p 5000:5000 ai-chatbot
```

Access at: [http://localhost:5000](http://localhost:5000)

---

## Deploying with k0s

Deploy to your k0s cluster with zero friction:

```bash
# Initialize k0s
sudo k0s start
sudo k0s kubectl get nodes

# Load the image into k0s
docker save ai-chatbot -o ai-chatbot.tar
sudo k0s ctr images import ai-chatbot.tar

# Apply the YAML files:
sudo k0s kubectl apply -f k8s/deployment.yaml
sudo k0s kubectl apply -f k8s/service.yaml

# Check if it’s working:
sudo k0s kubectl get pods
sudo k0s kubectl get services
```
The app will be available at: [http://localhost:30001](http://localhost:30001)

---

## Enterprise Scaling

For production environments, utilize container registries:

```bash
# Tag and push the image:
docker tag ai-chatbot ghcr.io/hparpinel/ai-chatbot:latest
docker push ghcr.io/hparpinel/ai-chatbot:latest

# Optional: Create registry secret if needed
kubectl create secret docker-registry ghcr-creds \
  --docker-server=ghcr.io \
  --docker-username=YOUR_USERNAME \
  --docker-password=YOUR_GHCR_TOKEN \
  --docker-email=YOUR_USERNAME@email.com


# Then update the cluster config and apply:
sudo k0s kubeconfig admin > ~/.kube/config
kubectl apply -f k8s/deployment-ghcr.yaml

# Finally, check the new pod:
sudo k0s kubectl get pods

```

k0s makes scaling simple with:
- Automated load balancing
- Self-healing capabilities
- Built-in monitoring
- Zero-friction updates

---

## Project Layout
Here's a quick look at the project structure to understand how the components fit together:

```plaintext
k0s-ai-chatbot-demo/
├── k0s-demo
│   ├── app
│   │   ├── backend
│   │   │   ├── chatbot.py
│   │   │   ├── Dockerfile
│   │   │   └── requirements.txt
│   │   └── frontend
│   │       └── index.html
│   └── k8s
│       ├── deployment-ghcr.yaml
│       ├── deployment.yaml
│       └── service.yaml
├── docs
│   └── index.md
└── scripts
    └── install-dependencies.sh
```

---

## Next Steps

Want to dive deeper into k0s?

1. [Explore the official k0s documentation](https://docs.k0sproject.io)
2. [Learn more about k0s from Mirantis](https://www.mirantis.com/software/k0s)
3. [Join the Kubernetes Slack #k0s channel](https://slack.k8s.io/)

---

<sub>This project was created independently by Hellen Parpinel Hobbs as part of a technical demo. k0s is developed by Mirantis — used here under fair use for educational purposes.</sub>
