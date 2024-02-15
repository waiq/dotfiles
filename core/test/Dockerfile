# Use the official Ubuntu base image
FROM ubuntu:24.04

# This is my desired location
ENV TZ=America/New_York

# Avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install basic packages
RUN apt-get update && \
    apt-get install -y tzdata && \
	apt-get -y install sudo && \
	apt-get -y install python3-pip && \
	apt-get install -y git

# Specify the default command to run when the container starts
CMD ["bash"]
