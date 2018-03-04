# Criar cinco usu�rios no sistema

su
base="userlab"
for ((i=1; i <= 5; i++)); do temp=$base$i; adduser $temp ; done

# Fazendo login
for ((i=1; i <= 3; i++)); do login $base$i; done

# Dentro de cada usu�rio utilizei o comando
exit

# Removendo dois usu�rios
for ((i=5;i >= 4; i--); do temp=$base$i ; userdel -r $temp ; done

# Bloquear acesso a pasta do meu usu�rio padr�o
# Somente o usu�rio pode acessar
for ((i=1; i <= 3; i++)); do login $base$i; done

# Dentro de cada um dos usu�rios

## Altera a permiss�o para que somente ele acesses

# UGO
chmod u=rwx,g-rwx,o-rwx ~

# No caso do utilizei Octal
chmod 700 ~

# Saindo do usu�rio
exit

# Para testar as permiss�es deixei terminar o loop de logins
# Ao sair do loop, desloguei do root

exit

# Com o usu�rio normal tentei fazer o acesso aos diret�rios

cd /home/userlab1 ; pwd;  cd /home/userlab2 ; pwd ; cd /home/userlab3

# Nenhum deles permitiu o acesso

# Aplicando permiss�es de acesso a pasta do usu�rio e n�o ao subdiret�rios
# Cria cinco diret�rios
su
base="userlab"
for ((i=1; i <= 3; i++)); do login $base$i; done

# Dentro de cada usu�rio utilizar
name="pasta_"
for ((i=1;i<=5;i++)); do mkdir $name$i ; done

## Aplicando novas permiss�es
## Aqui todos podem acessar o diret�rio de usu�rio mas n�o os subdiret�rios
chmod a=rwx,g-w,o-w ~ ; chmod u=rwx pasta_*

## No caso do uso octal
chmod 755 ~ ; chmod 700 pasta_*

exit

# Para testar as permiss�es deixei terminar o loop de logins
# Ao sair do loop sai do root

exit

# Com o usu�rio normal tentei fazer o acesso aos diret�rios
cd /home/userlab1 ; pwd ;  cd /home/userlab2  ; pwd ; cd /home/userlab3 ; pwd

# O acesso foi concedido, por�m nos subdiret�rios n�o

# Comando usu�rio para testar
cd /home/userlab1/pasta_1 ; pwd ; cd /home/userlab2/pasta_1 ; pwd ; cd /home/userlab3/pasta_1 ; pwd

# Ainda no usu�rio sem root pede-se que seja feito um teste com a movimenta��o de um arquivo para o diret�rio bloqueado, ent�o tentemos

cd ~ ;  mkdir teste && mv teste /home/userlab1/pasta1/

# O comando acima retornou erro por n�o haver permiss�o


# Liberando acesso a todas as pastas novamente
su
chmod a=rx -R /home/userlab*

# Testando
exit
cd /home/userlab1 ; pwd ;  cd /home/userlab2  ; pwd ; cd /home/userlab3 ; pwd