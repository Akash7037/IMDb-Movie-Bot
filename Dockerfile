# Builder stage to install dependencies
FROM python:3.9 AS builder

# Update and install dependencies
RUN apt update && apt upgrade -y
RUN apt install git -y

# Copy your requirements.txt into the image and install dependencies
COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Production stage
FROM python:3.9-slim AS prod

# Install latest pip and dependencies for production
RUN pip3 install -U pip
COPY --from=builder /requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt

# Setup the working directory and copy start.sh
WORKDIR /IMDb-Movie-Bot
COPY start.sh /start.sh

# Set the command to run the bot
CMD ["/bin/bash", "/start.sh"]
