# Base image
FROM ubuntu:latest

# Install certbot
RUN apt-get update && apt-get -y install certbot

# Install cron
RUN apt-get -y install cron

# Copy the script to the container
COPY check_validate_tls.sh /check_validate_tls.sh

# Set the script as executable
RUN chmod +x /check_validate_tls.sh

# Add cron job to run the script every hour
RUN echo "* */1 * * * /check_validate_tls.sh" >> /etc/crontab

# Start cron service
CMD cron -f
