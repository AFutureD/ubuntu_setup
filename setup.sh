#!/bin/bash

sudo apt update
sudo apt install -y vim git openssh-server net-tools zsh ibus-pinyin ibus-sunpinyin
ibus restart
# oh my zsh
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh -l::g' | sed 's:chsh -s .*$::g')"

# chrome 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o ./google-chrome-stable_current_amd64.deb
sudo dpkg -i ./google-chrome-stable_current_amd64.deb

# TODO VSCODE、CHROME、 torch 

execute bash ./beautify.sh

## shadowsocks in v2ray
# bash <(curl -L -s https://install.direct/go.sh) 
# echo "export PATH=$PATH:/usr/bin/v2ray" >> ~/.bashrc
# sudo ln -s /usr/bin/v2ray/v2ray /usr/bin/v2ray
# sudo ln -s /usr/bin/v2ray/v2ctl /usr/bin/v2ctl
# sudo mv /etc/v2ray/config.json /etc/v2ray/config.json.backup
# sudo mv -f v2ray_config.json 
# sudo service v2ray start


# wget https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh -O ./anaconda.sh
# yes | bash ./anaconda.sh

# install anaconda
continuum_website=https://repo.continuum.io/archive/
latest_anaconda_steup=$(wget -q -O - $continuum_website index.html | grep "Anaconda3-" | grep "Linux" | grep "86_64" | head -n 1 | cut -d \" -f 2)
wget ${continuum_website}${latest_anaconda_steup} -o ./anacondaInstallScript.sh
sudo mkdir -p /opt/anaconda3 && sudo chmod ugo+w /opt/anaconda3
execute bash ./anacondaInstallScript.sh -f -b -p /opt/anaconda3

# anaconda packages
execute /opt/anaconda3/bin/conda update conda -y
execute /opt/anaconda3/bin/conda clean --all -y
execute /opt/anaconda3/bin/conda install ipython -y
execute /opt/anaconda3/bin/pip install numpy scipy matplotlib scikit-learn scikit-image jupyter notebook pandas

# torch 
# wget https://download.pytorch.org/whl/cu100/torch-1.0.0-cp37-cp37m-linux_x86_64.whl -o ./torch-1.0.0-cp37-cp37m-linux_x86_64.whl
# wget https://files.pythonhosted.org/packages/fb/01/03fd7e503c16b3dc262483e5555ad40974ab5da8b9879e164b56c1f4ef6f/torchvision-0.2.2.post3-py2.py3-none-any.whl -o ./torchvision-0.2.2.post3-py2.py3-none-any.whl


# PATH
# {
#     # echo "export PATH=$PATH:/usr/bin/v2ray"
#     echo "export PATH=$PATH:/opt/anaconda3/bin"
# } >> ~/.zshrc

# alias
# {
#     echo "alias jn=\"jupyter notebook\""
#     echo "alias jl=\"jupyter lab\""
# } >> ~/.zshrc

# effact zsh
sudo chsh -s "which zsh"