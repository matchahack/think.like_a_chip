FROM alienflip/bsides_bristol_matchahack_img:latest

# Create a working directory
WORKDIR /root/bsides_bristol_matchahack

# Install nextpnr
RUN git clone https://github.com/matchahack/nextpnr.git && \
    cd nextpnr && \
    git submodule update --init --recursive && \
    mkdir -p build && \
    cd build && \
    cmake .. -DARCH="himbaechel" -DHIMBAECHEL_UARCH="gowin" && \
    make -j"$(nproc)" && \
    make install && \
    cd /root/bsides_bristol_matchahack && rm -rf nextpnr

# Install openFPGALoader
RUN git clone https://github.com/matchahack/openFPGALoader.git && \
    cd openFPGALoader && \
    mkdir build && \
    cd build && \
    cmake ../ && \
    cmake --build . && \
    make -j"$(nproc)" install && \
    cd /root/bsides_bristol_matchahack && rm -rf openFPGALoader

# Install yosys
RUN git clone https://github.com/matchahack/yosys.git && \
    cd yosys && \
    git submodule update --init --recursive && \
    make -j"$(nproc)" && \
    make install && \
    cd /root/bsides_bristol_matchahack && rm -rf yosys

# Default shell
CMD ["/bin/bash"]