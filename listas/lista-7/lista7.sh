# 1 - Crie três arquivos de texto, com a extensão .txt, como segue:

vim arquivo1.txt
vim arquivo2.txt
vim arquivo3.txt
vim arquivo4.txt

# 2 - Transforme  os  arquivos  em  um  tarball  e  envie, por scp, para um  de  seus  colegas. Faça isso para as duas formas de compactação gzip e bzip.

## Transformando em tarball e compactando
### GZIP
tar -cvzf scriptsOne.tar.gz arquivo1.txt arquivo2.txt arquivo3.txt arquivo4.txt 

### BZIP
tar -cvjf scriptsTwo.tar.bz arquivo1.txt arquivo2.txt arquivo3.txt arquivo4.txt 

## O scp fiz entre a VM e minha máquina física
### Da vm debian para meu pc
scp *.tar.* felipe@192.168.0.17

# 3 - Se  você foi  o  colega que  recebeu  o  arquivo. Tente  extrair  os  arquivos  do  tarball  e mude a extensão de .txt para .sh.
# Movendo para um diretório somente para gzip e descompactando para gzip
mkdir gzip && mv scriptsOne.tar.gz gzip && cd gzip && tar -xvzf scriptsOne.tar.gz

cd ..

# Movendo para um diretório somente bzip e descompactando
mkdir bzip && mv scriptsTwo.tar.bz bzip && cd bzip && tar -xvjf scriptsTow.tar.gz

# Mudando a extensão
mv arquivo1.txt arquivo1.sh ; mv arquivo2.txt arquivo2.sh ; mv arquivo3.txt arquivo3.sh ; mv arquivo4.txt arquivo4.sh

# 4 - Execute cada um dos arquivos .sh.

## Dando permissão de execução
chmod +x *.sh

# Executando os arquivos
./arquivo1.sh
./arquivo2.sh
./arquivo3.sh
./arquivo4.sh

# 5 - A execução do arquivo4 irá criar outros arquivos. Junte esses arquivos em um tarball e devolva ao seu colega usando o scp
tar -cvzf arquivosGerados.tar.gz *.txt

scp arquivosGerados.tar.gz felipe@192.168.0.11:/home/felipe 
