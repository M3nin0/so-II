# Lista 12 - Felipe Menino

su

# 1. Lista as informa��es do pacote openssh-server

## Listando informa��es gerais
dpkg -l openssh-server

## Listando diret�rios que cont�m algum tipo de depend�ncia com o pacote pesquisado
dpkg -L openssh-server

# 2. Remover o pacote e suas depend�ncia

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

## Para o pacote tar n�o � poss�vel realizar a exclus�o do pacote, j� que ele � 'essential' do sistema.