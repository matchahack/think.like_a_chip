sudo rm -rf ~/bsides_bristol_matchahack

cd /usr/local/share
sudo rm -rf nextpnr/ openFPGALoader/ yosys/
cd /usr/local/bin
sudo rm -rf yosys* nextpnr-himbaechel openFPGALoader

mkdir ~/bsides_bristol_matchahack
cd ~/bsides_bristol_matchahack

start=$SECONDS

sudo apt-get update
sudo apt-get install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
libffi-dev liblzma-dev git cmake libboost-all-dev libeigen3-dev \
libftdi1-2 libftdi1-dev libhidapi-hidraw0 libhidapi-dev \
libudev-dev zlib1g-dev pkg-config g++ clang bison flex \
gawk tcl-dev graphviz xdot pkg-config zlib1g-dev --y

sudo apt-get install iverilog
sudo apt-get install gtkwave

if [ ! -d "$HOME/.pyenv" ]; then
    curl https://pyenv.run | bash
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.bashrc
fi

pyenv install 3.9.13
pyenv global 3.9.13

pip install apycula

# matchahack HDLs
git clone git@github.com:matchahack/think.like_a_chip.git

# load designs onto FPGA
cd ~/bsides_bristol_matchahack
git clone https://github.com/matchahack/openFPGALoader.git
cd openFPGALoader
mkdir build
cd build
cmake ../ 
cmake --build .
sudo make -j$(nproc) install 

# vendor specific component mappings
cd ~/bsides_bristol_matchahack
git clone https://github.com/matchahack/nextpnr.git
cd nextpnr
git submodule update --init --recursive
git checkout e642e21f9bb6ba05b62458e29c04c4e64287ecdc
mkdir -p build && cd build
cmake .. -DARCH="himbaechel" -DHIMBAECHEL_UARCH="gowin"
make -j$(nproc)
sudo make -j$(nproc) install

# compile hardware design into generic bitstream
cd ~/bsides_bristol_matchahack
git clone https://github.com/matchahack/yosys.git
cd yosys
git submodule update --init --recursive
make -j$(nproc)
sudo make -j$(nproc) install

duration=$(( SECONDS - start ))
echo "install time (seconds): " $duration