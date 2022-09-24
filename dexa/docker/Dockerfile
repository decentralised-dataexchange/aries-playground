FROM ubuntu:18.04 as builder

ARG user=indy
ENV HOME="/home/$user"
WORKDIR $HOME
RUN mkdir -p .local/bin .local/etc .local/lib

# Install environment
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    automake \
    bison \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    flex \
    git \
    libbz2-dev \
    libffi-dev \
    libgmp-dev \
    liblzma-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-gplv2-dev \
    libsecp256k1-dev \
    libsqlite3-dev \
    libssl-dev \
    libtool \
    libzmq3-dev \
    pkg-config \
    zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# 3.5.3+ required
ARG python_version=3.8.3

# Install pyenv and python to user home directory
ENV PYENV_ROOT="$HOME/.pyenv"
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
RUN git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT" && \
    CFLAGS="-O2" pyenv install $python_version && \
    pyenv global $python_version && \
    find "$PYENV_ROOT" -depth \
    \( \
    \( -type d -a \( -name test -o -name tests \) \) \
    -o \
    \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
    \) -exec rm -rf '{}' + && \
    pip install --no-cache-dir --upgrade pip


RUN pip3 install dexa-sdk==0.1.8

FROM bcgovimages/von-image:py36-1.15-0

USER root

# Copy build results
COPY --from=builder --chown=indy:indy $HOME .

# Support standard python paths used in scripts
ENV PYENV_ROOT="$HOME/.pyenv"

# Add selected version of python and local bin directories
ENV PATH="$HOME/.local/bin:$HOME/bin:$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

USER indy

ENV ENABLE_PTVSD 0

RUN mkdir logs && chown -R indy:indy logs && chmod -R ug+rw logs

USER root

# System deps:
RUN pip install "poetry==1.2.0"

# Copy only requirements to cache them in docker layer
WORKDIR /code
COPY poetry.lock pyproject.toml /code/

# Project initialization:
RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi

# Creating folders, and files for a project:
COPY main.py /code

ENTRYPOINT python -m main.py "$@"