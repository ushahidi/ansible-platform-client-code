FROM tuxpiper/ansible-testinfra-docker:ubuntu-trusty

RUN { curl -sL https://deb.nodesource.com/setup_4.x | bash ; } && \
    apt-get update && apt-get install -y git nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
