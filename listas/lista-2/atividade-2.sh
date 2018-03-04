# Criar cinco usuários no sistema

su
base="userlab"
for ((i=1; i <= 5; i++)); do temp=$base$i; adduser $temp ; done

# Fazendo login
for ((i=1; i <= 3; i++)); do login $base$i; done

# Dentro de cada usuário utilizei o comando
exit

# Removendo dois usuários
for ((i=5;i >= 4; i--); do temp=$base$i ; userdel -r $temp ; done

# Bloquear acesso a pasta do meu usuário padrão
# Somente o usuário pode acessar
for ((i=1; i <= 3; i++)); do login $base$i; done

# Dentro de cada um dos usuários

## Altera a permissão para que somente ele acesses

# UGO
chmod u=rwx,g-rwx,o-rwx ~

# No caso do utilizei Octal
chmod 700 ~

# Saindo do usuário
exit

# Para testar as permissões deixei terminar o loop de logins
# Ao sair do loop, desloguei do root

exit

# Com o usuário normal tentei fazer o acesso aos diretórios

cd /home/userlab1 ; pwd;  cd /home/userlab2 ; pwd ; cd /home/userlab3

# Nenhum deles permitiu o acesso

# Aplicando permissões de acesso a pasta do usuário e não ao subdiretórios
# Cria cinco diretórios
su
base="userlab"
for ((i=1; i <= 3; i++)); do login $base$i; done

# Dentro de cada usuário utilizar
name="pasta_"
for ((i=1;i<=5;i++)); do mkdir $name$i ; done

## Aplicando novas permissões
## Aqui todos podem acessar o diretório de usuário mas não os subdiretórios
chmod a=rwx,g-w,o-w ~ ; chmod u=rwx pasta_*

## No caso do uso octal
chmod 755 ~ ; chmod 700 pasta_*

exit

# Para testar as permissões deixei terminar o loop de logins
# Ao sair do loop sai do root

exit

# Com o usuário normal tentei fazer o acesso aos diretórios
cd /home/userlab1 ; pwd ;  cd /home/userlab2  ; pwd ; cd /home/userlab3 ; pwd

# O acesso foi concedido, porém nos subdiretórios não

# Comando usuário para testar
cd /home/userlab1/pasta_1 ; pwd ; cd /home/userlab2/pasta_1 ; pwd ; cd /home/userlab3/pasta_1 ; pwd

# Ainda no usuário sem root pede-se que seja feito um teste com a movimentação de um arquivo para o diretório bloqueado, então tentemos

cd ~ ;  mkdir teste && mv teste /home/userlab1/pasta1/

# O comando acima retornou erro por não haver permissão


# Liberando acesso a todas as pastas novamente
su
chmod a=rx -R /home/userlab*

# Testando
exit
cd /home/userlab1 ; pwd ;  cd /home/userlab2  ; pwd ; cd /home/userlab3 ; pwd