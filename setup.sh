#!/bin/bash
echo "Building .bashrc and .bash_profile..."
echo "source ${HOME}/env/bashrc" > ${HOME}/.bashrc
cp ${HOME}/env/bash_profile ${HOME}/.bash_profile
cp ${HOME}/env/bash_profile ${HOME}/.bashrc

echo "Linking .vim to env/vim..."
rm -rf ${HOME}/.vim
ln -s ${HOME}/env/vim ${HOME}/.vim



