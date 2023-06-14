# Use the official image as a parent image
FROM python:3.9-alpine

# Set the working directory in the Docker container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Upgrade pip
RUN pip3 install --upgrade pip

# Install any needed packages specified in requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# Run app.py when the container launches
CMD ["python3", "scan_worker.py"]

