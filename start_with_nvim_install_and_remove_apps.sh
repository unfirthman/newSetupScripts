#! bin/bash

# begin update

{
  sudo apt remove thunderbird --purge -y && sudo apt remove rhythmbox --purge -y && sudo apt remove libreoffice-core --purge -y && sudo apt remove shotwell --purge -y && sudo apt remove cheese --purge -y && sudo apt remove remmina --purge -y && sudo apt remove aisleriot --purge -y && sudo apt remove gnome-mahjongg --purge -y && sudo apt remove gnome-mines --purge -y && sudo apt remove gnome-calendar --purge -y

  sudo apt-get update && sudo apt-get upgrade -y && sudo apt autoremove -y

  wait

  sudo apt-get update && sudo apt-get update -y && sudo apt autoremove -y

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

  # Let's add NVIM!

  git clone https://github.com/neovim/neovim

  cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo

  wait

  sudo make install

  wait

  cd

  # Now let's add some dot files

  git clone https://github.com/unfirthman/dot-files

  wait

  # Download and install ohmyzsh

  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  wait

  cd

  wait

  sudo apt-get update && sudo apt-get update -y && sudo apt autoremove -y

} | tee -a ./welcomeLog.txt
