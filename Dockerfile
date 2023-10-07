# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install required packages for system
# - Update package lists and upgrade existing packages
# - Install GCC (for compiling Python packages), libmysqlclient (for MySQL), and pkg-config (for package configuration)
# - Clean up cached package lists to reduce image size
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
# This assumes you have a 'requirements.txt' file in the same directory as the Dockerfile
COPY requirements.txt .

# Install app dependencies
# - Install the 'mysqlclient' Python package, which is required to interact with MySQL databases
# - Install other Python dependencies listed in 'requirements.txt' (use --no-cache-dir to avoid caching)
RUN pip install mysqlclient \
    && pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
# This assumes you have all your application files in the same directory as the Dockerfile
COPY . .

# Specify the command to run your application
CMD ["python", "app.py"]
