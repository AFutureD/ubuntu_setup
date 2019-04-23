#!/bin/bash

install_tsinghua() {
    if [ -f /etc/apt/sources.list ]; then
        sudo mv /etc/apt/sources.list /etc/apt/sources.list.backup
    else
        sudo touch /etc/apt/sources.list
    fi
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse" >> /etc/apt/sources.list'
    sudo sh -c 'echo "# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse" >> /etc/apt/sources.list'

}

install_basic() {
    sudo apt update
    sudo apt-get remove -y --purge libreoffice\* thunderbird gnome-sudoku gnome-mahjongg gnome-mines aisleriot
    sudo apt install -y vim git openssh-server net-tools zsh  curl ibus-pinyin ibus-sunpinyin
    ibus restart
    # oh my zsh
    # sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh -l::g' | sed 's:chsh -s .*$::g')"

    # chrome 
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ./google-chrome-stable_current_amd64.deb
    sudo dpkg -i ./google-chrome-stable_current_amd64.deb
    sudo apt-get install -f
}

# shadowsocks in v2ray
install_v2ray() {
    curl -L -s https://install.direct/go.sh | bash 
    echo "export PATH=$PATH:/usr/bin/v2ray" >> ~/.bashrc
    sudo ln -s /usr/bin/v2ray/v2ray /usr/bin/v2ray
    sudo ln -s /usr/bin/v2ray/v2ctl /usr/bin/v2ctl
    wget https://raw.githubusercontent.com/AFutureD/ubuntu_setup/master/v2ray_config.json -O ./v2ray_config.json
    sudo mv /etc/v2ray/config.json /etc/v2ray/config.json.backup
    sudo mv -f v2ray_config.json 
    sudo service v2ray start
}

# install anaconda
install_anaconda() {

    continuum_website=https://repo.continuum.io/archive/
    latest_anaconda_steup=$(wget -q -O - $continuum_website index.html | grep "Anaconda3-" | grep "Linux" | grep "86_64" | head -n 1 | cut -d \" -f 2)
    wget ${continuum_website}${latest_anaconda_steup} -O ./anacondaInstallScript.sh
    sudo mkdir -p /opt/anaconda3 && sudo chmod ugo+w /opt/anaconda3
    bash ./anacondaInstallScript.sh -f -b -p /opt/anaconda3

    # anaconda packages
    execute /opt/anaconda3/bin/conda update conda -y
    execute /opt/anaconda3/bin/conda clean --all -y
    execute /opt/anaconda3/bin/conda install ipython -y
    execute /opt/anaconda3/bin/pip install numpy scipy matplotlib scikit-learn scikit-image jupyter notebook pandas
}

install_torch() {
    wget https://download.pytorch.org/whl/cu100/torch-1.0.0-cp37-cp37m-linux_x86_64.whl -O ./torch-1.0.0-cp37-cp37m-linux_x86_64.whl
    wget https://files.pythonhosted.org/packages/fb/01/03fd7e503c16b3dc262483e5555ad40974ab5da8b9879e164b56c1f4ef6f/torchvision-0.2.2.post3-py2.py3-none-any.whl -O ./torchvision-0.2.2.post3-py2.py3-none-any.whl
}

setup_zshrc() {
    # PATH
    {
        # echo "export PATH=$PATH:/usr/bin/v2ray"
        echo "export PATH=$PATH:/opt/anaconda3/bin"
    } >> ~/.zshrc

    # alias
    # {
    #     echo "alias jn=\"jupyter notebook\""
    #     echo "alias jl=\"jupyter lab\""
    # } >> ~/.zshrc
}

main(){
    install_tsinghua
    install_basic
    # beautify
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/AFutureD/ubuntu_setup/master/beautify.sh)"
    # install_anaconda
    # install_v2ray

    # effact zsh
    setup_zshrc
    sudo chsh -s $(which zsh)
}
main
