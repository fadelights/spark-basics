FROM spark

USER root

# Install system dependencies
RUN apt update && apt install -y \
    git \
    curl \
    wget \
    sudo \
    python3-pip \
    python3-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN python3 -m pip install --upgrade pip \
    && python3 -m pip install --verbose \
    numpy \
    scipy \
    pandas \
    pyarrow \
    ipython \
    jupyterlab \
    jupyter_server_proxy \
    && python3 -m pip cache purge

# Create a non-root user with sudo access
RUN useradd -m -s /bin/bash mani \
    && echo "mani ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/mani \
    && chmod 0440 /etc/sudoers.d/mani

# Set up Spark environment variables
ENV PYSPARK_DRIVER_PYTHON=jupyter
ENV PYSPARK_DRIVER_PYTHON_OPTS="lab --no-browser --port=8888 --ip=0.0.0.0 --allow-root"

USER mani
WORKDIR /home/mani/ipyspark
EXPOSE 8888

CMD [ "/opt/spark/bin/pyspark" ]
