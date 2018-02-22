# Lista de exercícios 1 

# Listando todos os arquivos (Ocultos ou não)
cd /etc/ && ls -a

# Criando 6 diretórios, e dentro de cada diretório 3 arquivos
for ((i=0; i < 6; i++)); do mkdir ./$i ; for ((j=0; j < 3; j++)); do > ./$i/$j ; done ; done ; ls -lR

# Excluindo 3 diretórios
for ((i=0; i< 3; i++)); do rm ./$i/* && rmdir ./$i/ ; done; ls 

# Excluindo 2 diretórios de forma recursiva
for ((i=3; i< 6; i++)); do rm -rf ./%i/ ; done; ls 

# Copiando todos os arquivos (/etc/) para o diretório lixo
# Por não super-usuário alguns erros ocorrerão
mkdir lixo && cp -r /etc/* lixo

# Reiniciando o S.O
su
reboot

# Reiniciando S.O com tempo de 1 minuto
su
shutdown -r 1

# Desligando o sistema
su
poweroff

