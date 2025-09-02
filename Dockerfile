FROM alienflip/think_like_a_chip:latest

# Install nextpnr
WORKDIR /root/bsides_bristol_matchahack/nextpnr
RUN git submodule update --init --recursive && \
    mkdir -p build && \
    cd build && \
    cmake .. -DARCH="himbaechel" -DHIMBAECHEL_UARCH="gowin" && \
    make -j"$(nproc)" && \
    make install && \
    cd /root/bsides_bristol_matchahack && rm -rf nextpnr

# Install openFPGALoader
WORKDIR /root/bsides_bristol_matchahack/openFPGALoader
RUN mkdir build && \
    cd build && \
    cmake ../ && \
    cmake --build . && \
    make -j"$(nproc)" install && \
    cd /root/bsides_bristol_matchahack && rm -rf openFPGALoader

# Install yosys
WORKDIR /root/bsides_bristol_matchahack/yosys
RUN git submodule update --init --recursive && \
    make -j"$(nproc)" && \
    make install && \
    cd /root/bsides_bristol_matchahack && rm -rf yosys

WORKDIR /root/

CMD ["/bin/bash"]