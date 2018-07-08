#!/bin/bash
echo "Building .bashrc and .bash_profile..."
echo "source ${HOME}/env/bashrc" > ${HOME}/.bashrc
cp ${HOME}/.bashrc ${HOME}/.bash_profile

echo "Building .vimrc..."
echo "source ${HOME}/env/vimrc" > ${HOME}/.vimrc_shawn

echo "Linking .vim to env/vim..."
rm -f ${HOME}/.vim
ln -s ${HOME}/env/vim ${HOME}/.vim



