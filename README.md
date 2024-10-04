# Flask Application Deployment with Docker and CI/CD

This repository contains a simple Flask web application, containerized using Docker and integrated with a CI/CD pipeline using GitHub Actions. The pipeline includes building the Docker image, running static application security testing (SAST) with Bandit, and pushing the Docker image to Docker Hub.

## Table of Contents

- [Requirements](#requirements)
- [Folder Structure](#folder-structure)
- [Setup Instructions](#setup-instructions)
- [GitHub Actions CI/CD Pipeline](#github-actions-cicd-pipeline)
  - [Steps in the Workflow](#steps-in-the-workflow)
- [Dockerfile Explained](#dockerfile-explained)
- [Security with Bandit](#security-with-bandit)
- [Running Locally](#running-locally)

## Requirements

Before setting up and deploying the application, ensure you have the following:

- Docker installed on your local machine
- GitHub repository with permissions to create CI/CD pipelines
- Docker Hub account to store the Docker images
- Access to GitHub Secrets to store Docker Hub credentials