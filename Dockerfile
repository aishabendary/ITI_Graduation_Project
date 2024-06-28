# Use the official Jenkins image as the base image
FROM jenkins/jenkins:lts

# Switch to root user to install Docker and dependencies
USER root

# Install necessary packages
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common sudo && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce-cli tini

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Add Jenkins user to the Docker group
RUN groupadd docker
RUN usermod -aG docker jenkins

# Switch back to the Jenkins user
USER jenkins

# Expose the Jenkins web UI port
EXPOSE 8080

# Expose the Jenkins slave agent port
EXPOSE 50000

# Set the entrypoint to use tini with Jenkins entrypoint
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/jenkins.sh"]





