# Usar root para estas operações ?

# 1 - Acessar a raiz do sistema e listar os diretórios que lá existem. Salve em um arquivo a lista de pasta que irá aparecer

ls -l / > ~/a_raiz

# 2 - Liberar permissão de escrita para os diretórios /var e /srv
su

## UGO
chmod o+w /var /srv

## Octal - Leitura - Escrita - Execução
chmod 757 /var /srv

# 3 - Criar 3 novos usuários e para cada um criar um diretório dentro de /var e /srv. Os diretórios devem pertencer a seu respectivo usuário, grupo e não devem ter acesso livre para demais usuários do sistema.

nameBase="user"
for ((i=1;i<=3;i++)); do adduser $nameBase$i && login $nameBase$i ; done

## Dentro de cada usuário executei o seguintes comandos
### Usuário 1
	mkdir /var/user1 /srv/user1

	# Padrão UGO
	chmod a=rwx,o=-rwx /var/user1 /srv/user1
	ls -l /var/ 
	ls -l /srv/

	# Padrão Octal
	chmod 770 /var/user1 /srv/user1
	ls -l /var/ 
	ls -l /srv/
	exit

### Usuário 2
	mkdir /var/user2/ /srv/user2/
	 
	# Padrão UGO
	chmod a=rwx,o=-rwx /var/user2/ /srv/user2/
	ls -l /var/
	ls -l /srv/	

	# Padrão Octal
	chmod 770 /var/user2 /srv/user2
	ls -l /var/
	ls -l /srv/
	exit

### Usuário 3
	mkdir /var/user3/ /srv/user3/

	# Padrão UGO
	chmod a=rwx,o=-rwx /var/user3 /srv/user3/
	ls -l /var/
	ls -l /srv/	

	# Padrão Octal
	chmod 770 /var/user3 /srv/user3/
	ls -l /var/
	ls -l /srv/
	exit


# 4 - Bloquear acesso aos diretórios /var e /srv mantendo as permissões dos subdiretórios criados

## Padrão Octal
chmod 750 /var/ /srv/
ls -l /var/
ls -l /srv/

## Padrão UGO
chmod u=rwx,g=rx,o=-rwx /var/srv
ls -l /var/
ls -l /srv/

# 5 - Dentro de cada diretório criar um arquivo de texto (.txt) vazio. Este arquivo deverá ser criado por cada usuário, não use o root para isso.

login user1

# Dentro do usuário
> /srv/user1/teste.txt
## Erro ao executar
> /var/user1/teste.txt 
## Erro ao executar
exit

login user2
# Dentro do usuário
> /srv/user2/teste2.txt
## Erro ao tentar executar
> /var/user2/teste2.txt
## Erro ao tentar executar
exit

login user3
# Dentro do usuário
> /srv/user3/teste3.txt
## Erro ao tentar executar
> /var/user3/teste3.txt
## Erro ao tentar executar
exit

## Como pode ser visto neste exercício não foi possível executar os comandos pois não há permissão suficiente para os usuários

# 6 - Crie um outro arquivo vazio, no diretório /home de cada usuário. Copie esse arquivo para os diretórios /var e /srv de cada usuário.

login user1
# Dentro do usuário
cd ~
> teste.txt
cp teste.txt /var/
## Erro
cp teste.txt /srv/


login user2
# Dentro do usuário
cd ~
> teste2.txt
cp teste2.txt /var/
## Erro
cp teste2.txt /srv/



login user3
# Dentro do usuário
cd ~
> teste3.txt
cp teste3.txt /var/
## Erro
cp teste3.txt /srv/


## Neste caso também ocorrerá erro, pois não há permissões por parte do usuário para escrever dentro dos diretórios.
