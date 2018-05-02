1. Crie dois tipos de grupos de usuário no sistema . O primeiro deverá ser chamado de developers e o segundo de restorers
su

# Criando os grupos
addgroup developers
addgroup restorers

2. Cada grupo deverá ter pelo menos dois usuários associados , sendo um deles o administrador do grupo. 

# Criando usuários novos
adduser developerone
adduser restoreone

## Administradores dos grupos
adduser developeradmin
adduser restoreadmin

# Adicionando usuários aos grupos
gpasswd -a developerone developers
gpasswd -a developeradmin developers

gpasswd -a restoreone restorers
gpasswd -a restoreone restoreadmin

## Adicionando os administradores dos grupos
gpasswd -A developeradmin developers
gpasswd -A restoreadmin restorers

3. Na pasta /var crie duas subpastas, que deverão pertencer ao grupo restorers. Somente os usuários do grupo poderão ter acesso rwx às pastas. A primeira pasta deverá ser denominada de backup-in e a segunda de backup-out. Os demais usuários, pertencentes ao grupo developers, poderão apenas copiar conteúdo para a backup-in e ler/copiar o conteúdo da backup-out. Usuários que não estejam vinculados a um dos grupos devem ter acesso negado ao conteúdo das pastas, ou seja permissão 000.

# Criando diretório no /var

mkdir /var/backup-in
mkdir /var/backup-out

# Adicionando os grupos que fará as gerências de cada diretório

chgrp restorers /var/backup-in
chgrp restorers /var/backup-out

# Configurando regra geral de acesso aos arquivos
# chmod 070 /var/backup-in
# chmod 070 /var/backup-out

# Instalando ACL - Regras especiais
apt install acl

## Configurando o ACL
vim /etc/fstab

## Denstro do arquivo /etc/fstab, inserir a flag de ACL, neste caso na partição /var, já que é nesta que o ACL será utilizado

## Após inserir, basta realizar o remount
mount /var -o remount,acl

## Adicionando as permissões especiais
setfacl -Rm group:developers:wx /var/backup-in/
setfacl -Rm group:developers:rx /var/backup-out/

## Conferindo as regras ACL do arquivo
getfacl /var/backup-*

### Testando as regras
login developerone

#### Criando diretório
> /var/backup-in/admin_
#### Tentando visualizar
ls /var/backup-in/ # Permissão negada
exit

> /var/backup-out/456 # Negado
ls /var/backup-out/ # Permitido

login restoreone
#### Criando diretório
> /var/backup-in/usuario_normal
#### Tentando visualizar
ls /var/backup-in/
exit

> /var/backup-out/444 # Permitido
ls /var/backup-out # Permitido

4. A pasta /var deverá ser uma partição separada com o tamanho mínimo de 1GB.
# Verificando
df -h

Sist. Arq.      Tam. Usado Disp. Uso% Montado em
udev            488M     0  488M   0% /dev
tmpfs           100M  2,9M   97M   3% /run
/dev/sda1       4,6G  733M  3,6G  17% /
tmpfs           499M     0  499M   0% /dev/shm
tmpfs           5,0M     0  5,0M   0% /run/lock
tmpfs           499M     0  499M   0% /sys/fs/cgroup
/dev/sda6       2,7G  208M  2,4G   8% /var
/dev/sda5        88M  1,6M   81M   2% /home
tmpfs           100M     0  100M   0% /run/user/1001

5. A pasta /home de cada usuário no sistema deverá ter no máximo 50mb de quota total

# Instalando o pacote quote, para a gerência das quotas de usuário
apt install quota

# Habilitando o quota na partição /home
## Acessando o /var/fstab, para adicionar a flag de quota de usuário e grupo (usrquota, grpquota) no /home
vim /etc/fstab

## Realizando o remout
mount /home -o remount,quota

## Desabilitando o sistema de quota
quotaoff -augv

## Realizando check (Cria diretórios necessários para o funcionamento efetivo do quota)
quotacheck -augv

## Criando regra de cota no usuário 'felipe'
edquota felipe

## Criando regra de cota no grupo developers
edquota -g developers

## As regras para o usuário ('felipe') e para o grupo ('developers'), são as seguintes:
Filesystem                   blocks       soft       hard     inodes     soft     hard
/dev/sda5                         7      25000      50000          4        0        0

## Replicando para os demais grupos e usuários
edquota -p developers -g restorers
edquota -p felipe user01

## Conferindo as cópias de regras
edquota user01
edquota -g restorers

# Verificando mudanças nas regras do quota e habilitando serviço novamente
quotacheck -augv
quotaon -augv

## Realizando teste
login user01

# Criando arquivo de 55 MB
dd if=/dev/zero of=/home/user01/teste bs=1M count=55

# A seguinte mensagem é exibida -> dd: erro de escrita de '/home/user01/teste': Disk quota exceeded
exit

6. A cada 1 min, uma rotina deverá acessar a subpasta backup-in, do grupo restorers, e criar um tarball com todo conteúdo que existir. Isto servirá de backup, para os arquivos inseridos pelos usuários do grupo developers. Em seguida a rotina deverá copiar o tarball para a subpasta backup-out. O nome do arquivo deverá seguir o padrão ano-mês-dia, por exemplo: 2007-03-20.tar.bz.

# Adicionando regra no crontab
## Usuário com permissão
login restoreadmin
## Criando a regra
crontab -e
*/1 * * * * tar -zcf /var/backup-in/$(date +\%Y-\%m-\%d).tar.gz /var/backup-in/*
*/1 * * * * cp /var/backup-in/$(date +\%Y-\%m-\%d).tar.gz /var/backup-out/

## Após um minuto, é feito a verificação do backup (Os dados copiados são os mesmos utilizados nos testes acima)
