mkdir bsides_matchahack
cd bsides_matchahack

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install pyenv
pyenv install 3.9.13
pyenv global 3.9.13

pip install apycula

brew install cmake
brew install eigen

brew install openfpgaloader
brew install icarus-verilog
brew install --cask gtkwave

git clone git@github.com:matchahack/.think_like_a_chip.git

git clone https://github.com/matchahack/nextpnr.git
cd nextpnr
mkdir -p build && cd build
cmake .. -DARCH="himbaechel" -DHIMBAECHEL_UARCH="gowin"
make -j$(nproc)
sudo make -j$(nproc) install

brew install yosys