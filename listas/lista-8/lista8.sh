# Lista 8

# 1 - Liste quantos grupos existem no sistema e para cada grupo, seus respectivos usuários.

## Perguntar ao professor sobre - Posso manter esta resposta
more /etc/group

# 2 - Crie três grupos  novos  em  seu  sistema.  O  nome  de  cada  grupo  é  arbitrário,  você  escolhe.

su

## Criando grupos
groupadd grupoOne

groupadd grupoTwo

groupadd grupoThree

# 3 - Repita o passo do item 1

more /etc/group

# 4 - Adicione os usuários, todos eles com exceção do root, aos novos grupos criados. Para isso use o usuário root

addgroup usuário grupo.

## Usuário 'livre'
addgroup livre grupoOne
addgroup livre grupoTwo
addgroup livre grupoThree

## Usuário 'user1'
addgroup user1 grupoOne
addgroup user1 grupoTwo
addgroup user1 grupoThree

## Usuário 'user2'
addgroup user2 grupoOne
addgroup user2 grupoTwo
addgroup user2 grupoThree

# 5 - Para cada grupo criado defina um usuário como administrador , que não seja o root, sendo que um usuário só deve administrar um grupo.

gpasswd –A livre grupoOne
gpasswd -A user1 grupoTwo
gpasswd -A user2 grupoThree

# 6 - Adicione  mais  dois  novos  usuários  no  sistema.  Cada  usuário  administrador  deve adicionar os dois novos usuários ao seu respectivo grupo.

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

## Conferindo as duas primeiras adições
id user6
id user7

## Adicionando o terceiro grupo
login user2

gpasswd -a user6 grupoThree
gpasswd -a user7 grupoThree

## Conferindo os usuários
id user6
id user7

exit

# 7 - Repita o passo 1

more /etc/group

# 8 - Defina novos nomes para os grupos criados
groupmod -n grupoUm grupoOne

## Fazendo a verificação das mudanças
more /etc/group
id user6

groupmod -n grupoDois grupoTwo

groupmod -n groupoTres grupoThree

## Fazendo a verificação das mudanças
more /etc/group
id user6
id user7

# 9 - Repita o passo 1
more /etc/group

# 10 - Crie arquivos de texto, na mesma quantidade de grupos, dentro da pasta /var com o usuário root. A cada arquivo deverá ser atribuído um dos grupos.

> /var/grupoUm
> /var/grupoDois
> /var/grupoTres

chgrp grupoUm /var/grupoUm
chgrp grupoDois /var/grupoDois
chgrp grupoTres /var/grupoTres

## Verificando
ls -l /var | grep grupo

# 11 - Modifique a permissão de cada arquivo de modo que apenas os membros do grupo e o dono daquele arquivo possam alterar seu conteúdo.

chmod 660 /var/grupoUm
chmod 660 /var/grupoDois
chmod 660 /var/grupoTres

## Verificando

ls -l /var | grep grupo

# 12 - Tente escrever algo dentro de cada arquivo, usando um usuário que não pertence  ao grupo do arquivo, verifique se o sistema nega a permissão.
login felipe # Usuário fora dos grupos

echo "Teste" >> /var/grupoUm  #erro de permissão
echo "Teste" >> /var/grupoDois  #erro de permissão
echo "Teste" >> /var/grupoTres  #erro de permissão

cat /var/grupoUm  #erro de permissão
cat /var/grupoDois  #erro de permissão
cat /var/grupoTres  #erro de permissão

exit

# 13 - Selecione  dois  dos  grupos  criados  para  remoção.  Antes  de  remover  um  grupo, primeiro remova todos os usuários que fazem parte daquele grupo.

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

# 15 - Para cada usuário, verifique as informações quanto a pertinência de grupo usando o comando id

id user1
id user2
id user6
id user7
id livre

