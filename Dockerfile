FROM node:4-slim
MAINTAINER Fábio Uechi <fabio.uechi@gmail.com>

# Install git
RUN apt-get update && apt-get install -y git

# Global install node tools
RUN npm set progress=false && \
    npm install --global --progress=false gulp bower npm-install-changed polymer-cli && \
    echo '{ "allow_root": true }' > /root/.bowerrc

# Binary may be called nodejs instead of node
RUN ln -s /usr/bin/nodejs /usr/bin/node

ENV DEVELOPER_USER developer
ENV HOME /home/${DEVELOPER_USER}
RUN useradd --create-home --home-dir ${HOME} --user-group -u 1000 ${DEVELOPER_USER}

# Define working directory.
WORKDIR /workspace