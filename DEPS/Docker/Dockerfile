FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && apt-get upgrade -y --fix-missing && \
    apt-get install -y \
    make build-essential libssl-dev zlib1g-dev \
    libftdi1-2 libftdi1-dev libhidapi-hidraw0 libhidapi-dev \
    libudev-dev pkg-config g++ clang bison flex \
    libffi-dev liblzma-dev git libboost-all-dev libeigen3-dev \
    gawk tcl-dev iverilog \
    libbz2-dev libreadline-dev \
    libsqlite3-dev wget curl llvm \
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

RUN mkdir ~/bsides_bristol_matchahack

WORKDIR /root/bsides_bristol_matchahack
RUN git clone https://github.com/matchahack/nextpnr.git && \
    cd nextpnr && \
    git submodule update --init --recursive && \
    mkdir -p build && \
    cd build && \
    cmake .. -DARCH="himbaechel" -DHIMBAECHEL_UARCH="gowin" && \
    make -j"$(nproc)" && \
    make install

WORKDIR /root/bsides_bristol_matchahack
RUN git clone https://github.com/matchahack/openFPGALoader.git && \
    cd openFPGALoader && \
    mkdir build && \
    cd build && \
    cmake ../ && \
    cmake --build . && \
    make -j$(nproc) install
    
WORKDIR /root/bsides_bristol_matchahack
RUN git clone https://github.com/matchahack/yosys.git && \
    cd yosys && \
    git submodule update --init --recursive && \
    make -j$(nproc) && \
    make install 

RUN cd /root/bsides_bristol_matchahack && \
    rm -rf yosys openFPGALoader nextpnr

WORKDIR /root/bsides_bristol_matchahack

CMD ["/bin/bash"]