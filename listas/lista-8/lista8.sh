# Lista 8

# 1 - Liste quantos grupos existem no sistema e para cada grupo, seus respectivos usu�rios.

## Perguntar ao professor sobre - Posso manter esta resposta
more /etc/group

# 2 - Crie tr�s grupos  novos  em  seu  sistema.  O  nome  de  cada  grupo  �  arbitr�rio,  voc�  escolhe.

su

## Criando grupos
groupadd grupoOne

groupadd grupoTwo

groupadd grupoThree

# 3 - Repita o passo do item 1

more /etc/group

# 4 - Adicione os usu�rios, todos eles com exce��o do root, aos novos grupos criados. Para isso use o usu�rio root

addgroup usu�rio grupo.

## Usu�rio 'livre'
addgroup livre grupoOne
addgroup livre grupoTwo
addgroup livre grupoThree

## Usu�rio 'user1'
addgroup user1 grupoOne
addgroup user1 grupoTwo
addgroup user1 grupoThree

## Usu�rio 'user2'
addgroup user2 grupoOne
addgroup user2 grupoTwo
addgroup user2 grupoThree

# 5 - Para cada grupo criado defina um usu�rio como administrador , que n�o seja o root, sendo que um usu�rio s� deve administrar um grupo.

gpasswd �A livre grupoOne
gpasswd -A user1 grupoTwo
gpasswd -A user2 grupoThree

# 6 - Adicione  mais  dois  novos  usu�rios  no  sistema.  Cada  usu�rio  administrador  deve adicionar os dois novos usu�rios ao seu respectivo grupo.

adduser user6
adduser user7

login livre
gpasswd -a user6 grupoOne
gpasswd -a user7 grupoOne

exit
login user1

gpasswd -a user6 grupoTwo
gpasswd -a user7 grupoTwo
exit

## Conferindo as duas primeiras adi��es
id user6
id user7

## Adicionando o terceiro grupo
login user2

gpasswd -a user6 grupoThree
gpasswd -a user7 grupoThree

## Conferindo os usu�rios
id user6
id user7

exit

# 7 - Repita o passo 1

more /etc/group

# 8 - Defina novos nomes para os grupos criados
groupmod -n grupoUm grupoOne

## Fazendo a verifica��o das mudan�as
more /etc/group
id user6

groupmod -n grupoDois grupoTwo

groupmod -n groupoTres grupoThree

## Fazendo a verifica��o das mudan�as
more /etc/group
id user6
id user7

# 9 - Repita o passo 1
more /etc/group

# 10 - Crie arquivos de texto, na mesma quantidade de grupos, dentro da pasta /var com o usu�rio root. A cada arquivo dever� ser atribu�do um dos grupos.

> /var/grupoUm
> /var/grupoDois
> /var/grupoTres

chgrp grupoUm /var/grupoUm
chgrp grupoDois /var/grupoDois
chgrp grupoTres /var/grupoTres

## Verificando
ls -l /var | grep grupo

# 11 - Modifique a permiss�o de cada arquivo de modo que apenas os membros do grupo e o dono daquele arquivo possam alterar seu conte�do.

chmod 660 /var/grupoUm
chmod 660 /var/grupoDois
chmod 660 /var/grupoTres

## Verificando

ls -l /var | grep grupo

# 12 - Tente escrever algo dentro de cada arquivo, usando um usu�rio que n�o pertence  ao grupo do arquivo, verifique se o sistema nega a permiss�o.
login felipe # Usu�rio fora dos grupos

echo "Teste" >> /var/grupoUm  #erro de permiss�o
echo "Teste" >> /var/grupoDois  #erro de permiss�o
echo "Teste" >> /var/grupoTres  #erro de permiss�o

cat /var/grupoUm  #erro de permiss�o
cat /var/grupoDois  #erro de permiss�o
cat /var/grupoTres  #erro de permiss�o

exit

# 13 - Selecione  dois  dos  grupos  criados  para  remo��o.  Antes  de  remover  um  grupo, primeiro remova todos os usu�rios que fazem parte daquele grupo.

more /etc/group

gpasswd -d user6 grupoUm
gpasswd -d user7 grupoUm
gpasswd -d livre grupoUm
gpasswd -d user1 grupoUm
gpasswd -d user2 grupoUm

tail /etc/group

groupdel grupoUm

tail /etc/group

gpasswd -d user6 grupoDois
gpasswd -d user7 grupoDois
gpasswd -d livre grupoDois
gpasswd -d user1 grupoDois
gpasswd -d user2 grupoDois

tail /etc/group

groupdel grupoDois

tail /etc/group

# 14 - Repita o passo 1
more /etc/group

# 15 - Para cada usu�rio, verifique as informa��es quanto a pertin�ncia de grupo usando o comando id

id user1
id user2
id user6
id user7
id livre

