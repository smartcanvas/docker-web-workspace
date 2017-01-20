FROM node:4-alpine

# Install git
RUN apk -U add \
	git \
	su-exec \
    && rm -rf /var/cache/apk/* /tmp/*

# Global install node tools
RUN npm set progress=false && \
    npm install --global --progress=false gulp bower npm-install-changed polymer-cli && \
    echo '{ "allow_root": true }' > /root/.bowerrc

# Binary may be called nodejs instead of node
RUN ln -s /usr/bin/nodejs /usr/bin/node

# ENV DEVELOPER_USER developer
# ENV HOME /home/${DEVELOPER_USER}
# RUN useradd --create-home --home-dir ${HOME} --user-group -u 1000 ${DEVELOPER_USER}
ENV gid=1000 uid=1000
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Define working directory.
WORKDIR /workspace

# Metadata params
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.label-schema.vendor="DeskDrop" \
      org.label-schema.url="https://deskdrop.co" \
      org.label-schema.name="DeskDrop local development Web Workspace" \
      org.label-schema.description="Alpine based Deskdrop web workspace" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.schema-version="1.0"

CMD ["run.sh"]