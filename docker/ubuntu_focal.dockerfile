FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM linux

ARG username
ARG uid
ARG gid
ARG locale=en_US.UTF-8

# Don't drop man pages and other files from the packages being installed
RUN mv /etc/dpkg/dpkg.cfg.d/excludes /tmp/dpkg_excludes.bk
# Reinstall all already installed packages in order to get the man pages back
RUN dpkg -l | grep ^ii | cut -d' ' -f3 | \
        xargs apt-get install --yes --no-install-recommends --reinstall

# Create the user and allow him to execute `sudo` without password
RUN addgroup --gid $gid $username && \
    adduser --uid $uid --gid $gid --home /home/$username \
        --disabled-password --gecos '' $username && \
    adduser $username sudo && \
    mkdir -p /etc/sudoers.d/ && \
    echo "$username ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$username
ENV LOGNAME=$username USER=$username

# Install apt-utils before anything else
RUN apt-get update && apt-get install --yes --no-install-recommends apt-utils

# Set the locale
RUN apt-get update && apt-get install --yes --no-install-recommends locales
RUN locale-gen $locale && update-locale LANG=$locale LC_CTYPE=$locale
ENV LANG=$locale LC_ALL=$locale

# Install the packages for Python development and convenient command line usage
RUN apt-get update && apt-get install --yes --no-install-recommends \
        sudo lsb-release software-properties-common tzdata bash-completion \
        coreutils less tree tmux vim gnupg2 ca-certificates ack git-core \
        man-db manpages manpages-dev \
        python3 python3-setuptools python3-pip python3-wheel twine \
        flake8 python3-flake8-docstrings python3-pytest-flake8 \
        mypy mypy-doc pylint pylint-doc python3-pytest \
        build-essential debhelper devscripts fakeroot dput
ENV PYTHONDONTWRITEBYTECODE=1
