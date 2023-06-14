# Use the Ubuntu 20.04 LTS image as a parent image
FROM ubuntu:20.04

# Set the user to root
USER root

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Set the working directory in the Docker container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install system dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    software-properties-common \
    curl \
    unzip \
    git \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y python3.9 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN git config --global user.email "code@finisterra.io" && \
    git config --global user.name "finisterra"

# Install Terraform 1.5.0
RUN curl -O https://releases.hashicorp.com/terraform/0.15.0/terraform_0.15.0_linux_amd64.zip \
    && unzip terraform_0.15.0_linux_amd64.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform_0.15.0_linux_amd64.zip

# Make Python 3.9 as the default python version
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1

# Upgrade pip
RUN pip3 install --upgrade pip

# Install any needed packages specified in requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog

# Set the default shell command to bash
CMD ["python3", "scan_worker.py"]
