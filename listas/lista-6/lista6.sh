# As pesquisas foram executadas com root para evitar erros com permissões durante a busca.
# 1 - Para  cada  usuário  no  sistema,  busque por  todos  os  arquivos  que  pertencem  ao  seu respectivo grupo.

su

# Verificando nome dos usuários registrados
tail /etc/passwd | grep /home

## Criando lista dos nomes encontrados
usuarios=("felipe" "usuario1" "usuario2" "usuario3" "user1" "user2" "user3")

## Filtrando buscar por cada um dos usuários
a=7; # Quantidade de elementos

for ((i=0;i<7;i++)); do echo Arquivos do ${usuarios[$i]} >> output.txt ; find / -type f -group ${usuarios[$i]} >> output.txt; done

# 2 - Use o comando locate para localizar os aquivos .txt de cada usuário no sistema

## Instalando o mlocate

apt-get install mlocate

## Atualizando a base de informações
updatedb

## Dúvida. Uso o find ?


# 3 - Use o comando find para localizar os aquivos .txt de cada usuário no sistema.
for ((i=0;i<7;i++)); do echo Arquivos .txt do ${usuarios[$i]} >> arquivos_txts; find / -type f -name "*.txt" -user ${usuarios[$i]} >> arquivos_txts ; done


# 4 - Para  cada  usuário  no  sistema, busque  por  todas  as  pastas  que  pertencem  a esse usuário. Faça isto usando os dois comandos locate e find.
## Usando find [X]
## Usando locate [?]

## Find
for ((i=0;i<7;i++)); do echo Diretorios do ${usuarios[$i]} >> dirs_users.txt; find / -type d -user ${usuarios[$i]} >>  dirs_users.txt ; done


# 5 - Busque  no  sistema  por  todas  as  pastas que  tenha  permissão:  777,  645,  654,  555. Use o comando find.
permissoes=("777" "645" "654" "555")
a=4

for ((i=0;i<a;i++)) ; do echo Permissoes ${permissoes[$i]} >> perms.txt ; find / -type d -perm -${permissoes[$i]} >> perms.txt; done

# 6 - Busque no sistema por todas os arquivos que tenha permissão: 777, 645, 654, 555. Use o comando find

for ((i=0;i<a;i++)) ; do echo Permissoes de arquivos do ${permissoes[$i]} >> files.txt ; find / -type f -perm -${permissoes[$i]} >> files.txt; done

# 7 - Busque  no  sistema  por  todas os arquivos  e  pastas  que  tenham  permissão de execução. Use o comando find
## Perguntar ao professor sobre esta questão
## Diretórios searchable!?
find / -executable >> permitidos.txt

# 8 - Busque  no  sistema  por  todas os arquivos  e  pastas  que não tenham  permissão  de execução. Use o comando find.

find / ! -executable >> negados.txt
