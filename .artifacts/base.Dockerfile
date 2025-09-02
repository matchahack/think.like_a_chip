FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && apt-get upgrade -y 
RUN apt-get install -y --fix-missing \
    make build-essential libssl-dev zlib1g-dev 
RUN apt-get install -y --fix-missing \
    libftdi1-2 libftdi1-dev libhidapi-hidraw0 libhidapi-dev \
    libudev-dev pkg-config g++ clang bison flex 
RUN apt-get install -y --fix-missing \
    libffi-dev liblzma-dev git libboost-all-dev libeigen3-dev
RUN apt-get install -y --fix-missing \
    gawk tcl-dev iverilog 
RUN apt-get install -y --fix-missing \
    libbz2-dev libreadline-dev \
    libsqlite3-dev wget curl llvm 
RUN apt-get install -y --fix-missing \
    libncursesw5-dev xz-utils \
    tk-dev libxml2-dev libxmlsec1-dev \
 && rm -rf /var/lib/apt/lists/*

RUN curl https://pyenv.run | bash
ENV PYENV_ROOT="/root/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PATH"
RUN bash -c 'eval "$(pyenv init -)" && pyenv install 3.9.13 && pyenv global 3.9.13'
ENV PATH="$PYENV_ROOT/shims:$PATH"
RUN pip install --no-cache-dir apycula
RUN echo "/root/.pyenv/versions/3.9.13/lib" > /etc/ld.so.conf.d/python3.9.conf && \
    ldconfig
    
RUN sed -i 's|http://archive.ubuntu.com/ubuntu|https://archive.ubuntu.com/ubuntu|g' /etc/apt/sources.list
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates gnupg wget lsb-release software-properties-common && \
    rm -rf /var/lib/apt/lists/*
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc | \
    gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
RUN echo "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/kitware.list
RUN apt-get update && apt-get install -y --no-install-recommends cmake && \
    rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /root/bsides_bristol_matchahack
RUN git clone https://github.com/matchahack/nextpnr.git
RUN git clone https://github.com/matchahack/openFPGALoader.git
RUN git clone https://github.com/matchahack/yosys.git