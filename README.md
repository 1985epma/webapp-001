Flask Application Deployment with Docker and CI/CD
This repository contains a simple Flask web application, containerized using Docker and integrated with a CI/CD pipeline using GitHub Actions. The pipeline includes building the Docker image, running a static application security test (SAST) with Bandit, and pushing the Docker image to Docker Hub.

Table of Contents
Requirements
Folder Structure
Setup Instructions
GitHub Actions CI/CD Pipeline
Steps in the Workflow
Dockerfile Explained
Security with Bandit
Running Locally
Requirements
Before setting up and deploying the application, ensure that you have the following:

Docker installed on your local machine
GitHub repository with the appropriate permissions to create CI/CD pipelines
Docker Hub account for storing the Docker images
Access to GitHub Secrets for storing Docker Hub credentials
Folder Structure
Here’s the basic folder structure for this project:

bash
Copy code
.
├── app.py                # The main Flask application
├── requirements.txt      # Python dependencies for the app
├── Dockerfile            # Dockerfile for building the container
├── .github
│   └── workflows
│       └── docker-publish.yml  # GitHub Actions workflow for CI/CD
├── README.md             # This README file
└── templates
    └── home.html         # Example HTML for the Flask app
Setup Instructions
Clone the Repository:

bash
Copy code
git clone https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPOSITORY_NAME.git
cd YOUR_REPOSITORY_NAME
Set Up Secrets in GitHub:

Go to your repository on GitHub.
Navigate to Settings > Secrets and Variables > Actions.
Add the following secrets:
DOCKER_USERNAME: Your Docker Hub username.
DOCKER_PASSWORD: Your Docker Hub password (or access token if using 2FA).
Configure the Dockerfile: Ensure that your Dockerfile is properly set up to build the Flask application and include the security analysis.

GitHub Actions CI/CD Pipeline
The CI/CD pipeline is defined in the docker-publish.yml file inside the .github/workflows/ directory. This pipeline is triggered whenever changes are pushed to the main branch or a pull request is opened.

Steps in the Workflow
Checkout Code: The repository is cloned in the runner environment so the code can be accessed.

yaml
Copy code
- name: Checkout repository
  uses: actions/checkout@v3
Set up Python Environment: We install python3-venv and create a virtual environment for running security checks using Bandit.

yaml
Copy code
- name: Set up Python environment
  run: |
    sudo apt-get install python3-venv
    python3 -m venv venv
    source venv/bin/activate
Run Security Check (Bandit): This step installs and runs Bandit, a static analysis tool to check for security issues in Python code.

yaml
Copy code
- name: Run SAST with Bandit
  run: |
    venv/bin/pip install bandit
    venv/bin/bandit -r . --exit-zero
Build and Push Docker Image: The Docker image is built using docker/build-push-action and pushed to Docker Hub using the credentials stored in GitHub Secrets.

yaml
Copy code
- name: Build and push Docker image
  uses: docker/build-push-action@v3
  with:
    context: .
    file: ./Dockerfile
    push: true
    tags: YOUR_DOCKER_USERNAME/your-image-name:latest
Dockerfile Explained
The Dockerfile defines how to build the Docker container for the Flask app and run the Bandit security test.

Key steps include:

Creating a virtual environment for Python dependencies:

dockerfile
Copy code
RUN python3 -m venv /opt/venv
Installing dependencies in the virtual environment:

dockerfile
Copy code
RUN /opt/venv/bin/pip install bandit
Running Bandit for security analysis:

dockerfile
Copy code
RUN /opt/venv/bin/bandit -r . --exit-zero
Starting the Flask app after building:

dockerfile
Copy code
CMD ["/opt/venv/bin/python", "app.py"]
Security with Bandit
Bandit is used to perform static analysis on the Python code to check for common security issues such as:

Use of insecure functions (e.g., eval())
Hardcoded credentials
Potential vulnerabilities in code logic
Bandit is run automatically as part of the Docker build process and as part of the GitHub Actions workflow.

Running Locally
To run the Flask application locally using Docker:

Build the Docker image:

bash
Copy code
docker build -t your-image-name .
Run the Docker container:

bash
Copy code
docker run -p 5005:5005 your-image-name
Access the Flask app: Open your browser and go to http://localhost:5005.