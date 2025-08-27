sudo apt update
sudo apt install -y cmake python3-pip python3-dev python3-venv wget unzip
cd tmp
wget https://github.com/cefore/cefpyco/archive/refs/heads/master.zip
unzip master.zip -d .

python3 -m vnev venvcef
. venvcef/bin/activate
pip3 install --upgrade build
pip3 install numpy click rich pytest pytest-sugar
cd cefpyco-master
cmake .
make
make install
