#! bin/bash


# begin update

{

sudo apt-get update && sudo apt-get upgrade -y

wait

sudo apt-get update && sudo apt-get update -y

wait

# install some packages

sudo apt-get install git curl npm node.js zsh python3 pip -y

wait

sudo apt-get install python3-pynvim ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip -y

wait

sudo apt-get update && sudo apt-get update -y

wait

# install some fonts

mkdir fontsNew && cd fontsNew

curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/SourceCodePro.zip

unzip SourceCodePro.zip -d ../../../usr/share/fonts/

curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip

unzip Hack.zip -d ../../../usr/share/fonts/

curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip

unzip NerdFontsSymbolsOnly.zip -d ../../../usr/share/fonts/

curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/UbuntuMono.zip

unzip UbuntuMono.zip -d ../../../usr/share/fonts/

wait

cd


# Now let's add some dot files
### This space was previously used to install nvim config directory

# Download and install ohmyzsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

} | tee -a ./welcomeLog.txt
