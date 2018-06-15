FROM ubuntu:18.04

# Build arguments.
ARG VCS_REF
ARG BUILD_DATE
ARG WINE_VERSION="3.0"

# Labels / Metadata.
LABEL maintainer="James Brink, brink.james@gmail.com" \
    decription="wine" \
    version="3.0" \
    org.label-schema.name="wine" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/jamesbrink/docker-template" \
    org.label-schema.schema-version="1.0.0-rc1"

# Create our group & user.
RUN set -xe; \
    groupadd -g 1000 wine; \
    useradd -g wine -u 1000 -s /bin/sh -d /wine -m wine;

# Install deps.
RUN set -xe; \
    dpkg --add-architecture i386; \
    apt-get update; \
    apt-get install -y wine-stable; \
    rm -rf /var/lib/apt/lists/*; \
    echo "${WINE_VERSION}" > /wine/version.txt; \
    chown wine:wine /wine/version.txt;

# Copy our entrypoint into the container.
COPY ./docker-assets /

# Setup our environment variables.
ENV PATH="/usr/local/bin:$PATH"

# Drop down to our unprivileged user.
USER wine

# Run winecfg
RUN winecfg

# Set our working directory.
WORKDIR /wine

# Setup our volume.
VOLUME /mnt/apps

# Set the entrypoint.
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Set the default command
CMD ["/bin/bash"]
