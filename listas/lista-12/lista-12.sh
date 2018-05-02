# Lista 12 - Felipe Menino

su

# 1. Lista as informações do pacote openssh-server

## Listando informações gerais
dpkg -l openssh-server

## Listando diretórios que contém algum tipo de dependência com o pacote pesquisado
dpkg -L openssh-server

# 2. Remover o pacote e suas dependência

apt purge openssh-server

# 3. Baixar e instalar o pacote openssh-server utilizando um  arquivo .deb

wget http://ftp.br.debian.org/debian/pool/main/o/openssh/openssh-server_7.4p1-10+deb9u3_i386.deb -O openssh.deb


dpkg -i openssh.deb

# Repetir os passos 1, 2, 3, com os pacotes vim e tar

## Vim
dpkg -l vim
dpkg -L vim
apt purge vim
wget http://ftp.br.debian.org/debian/pool/main/v/vim/vim_8.0.0197-4+deb9u1_i386.deb -O vim.deb

dpkg -i vim.deb

# Tar
dpkg -l tar
dpkg -L tar

## Para o pacote tar não é possível realizar a exclusão do pacote, já que ele é 'essential' do sistema.