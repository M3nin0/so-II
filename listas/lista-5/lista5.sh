# Dupla - Akira Kotsugai e Felipe Menino

# Ip do akira: 172.16.9.161
# Meu ip: 172.16.9.193

# Adicionando usuário para o akira
adduser livre

# Fazendo login no usuário criado
login livre

# Criando arquivo dentro do diretório do usuário
> arquivo_teste.txt

# Modificando permissão
chmod 644 arquivo_teste.txt

# Utilizando a copia remota
scp arquivo_teste.txt javeiro@172.16.9.161:/home/javeiro

# Recuperando o diretório

## Primeiro exclui o da minha máquina
rm arquivo_teste.txt

## Faço a recuperação
scp javeiro@172.16.9.161:/home/javeiro/arquivo_teste.txt novo_arquivo_teste.txt

# Verificando 
ls

# Criando diretório
mkdir dir_para_envio && > dir_para_envio/arquivo_de_envio.txt

# Fazendo envio do diretório
scp -r dir_para_envio javeiro@172.16.9.161:/home/javeiro

## Excluindo o diretório para testar
rm -rf dir_para_envio

## Recuperando
scp -r javeiro@172.16.9.161:/home/javeiro/dir_para_envio nova_dir

## Validando
ls
