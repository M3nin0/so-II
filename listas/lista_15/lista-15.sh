su

# Configurando a máquina - Servidor DHCP

## Instalando DHCP
apt-get update
apt-get install isc-dhcp-server

## Configurando as interfaces de rede
## Este servidor tem duas interfaces de rede
### enp0s3 - Rede Modo Bridge
### enp0s8 - Rede interna
vim /etc/network/interfaces

----A configuração das interfaces pode ser vista abaixo
allow-hotplug enp0s3
iface enp0s3 inet dhcp

allow-hotplug enp0s8
iface enp0s8 inet static
 address 192.168.10.253
 netmask 255.255.255.0
 network 192.168.10.0
 broadcast 192.168.10.255
----

## Habilitando a interface de rede enp0s8
ifup enp8s0

## Após concluir a configuração das interfaces, veja as configurações do DHCP server
## Configurando o DHCP
vim /etc/default/isc-dhcp-server

## Neste arquivo a opção *INTERFACESv4* foi alterado, e ficou da maneira vista abaixo.
## Esta configuração foi feita, para que a interface enp0s8, seja a responsável em distribuir os endereços.
INTERFACESv4="enp0s8"

## Realizando a configuração da distribuição dos endereços
vim /etc/dhcp/dhcpd.conf

## Neste arquivo, as seguintes linhas foram adicionadas

subnet 192.168.10.0 netmask 255.255.255.0 {
 range 192.168.10.200 192.168.10.250;
 option subnet-mask 255.255.255.0;
 option domain-name-servers 8.8.4.4;
 default-lease-time 600;
 max-lease-time 7200;
}

## Configurando endereço especifico para máquina ftp-anonimo
## Para isso será utilizado o MAC, assim o endereço IP ficará atrelado ao MAC
host ftp {
 hardware ethernet 08:00:27:13:8e:0e;
 fixed-address 192.168.10.252;
}

## Após a configuração
service isc-dhcp-server restart
service isc-dhcp-server status

## Com as configurações feitas acima, o processo de configuração do servidor DHCP está concluído. Veja agora a configuração do servidor FTP anônimo

# Configurando máquina - Servidor FTP anônimo

## Este servidor contém uma interface de rede
## enp0s3 - Rede interna
## O endereço atribuido a esta placa de rede será o 192.168.10.252, isso porque ela está na mesma rede interna que o DHCP, e como foi fixado na configuração este endereço, ele será atribuido sempre a esta máquina

## Instalando os pacotes que serão utilizados

## Estas instalações foram feitas utilizando a placa de rede em modo bridge, após este ela voltou a ficar em modo interno
apt-get update
apt-get install quota
apt-get install vsftpd

## Criando usuário adminftp
adduser adminftp

## Configurando o QUOTA 

### Adicionando o *usrquota* na partição /home
quotaoff -augv
vim /etc/fstab

### Habilitando o serviço
mount /home -o remount,quota
quotacheck -augv
quotaon -augv

### Adicionando regra para o adminftp. Neste o limite máximo será de 1GB
edquota adminftp

quotaoff -augv
quotacheck -augv
quotaon -augv

### Testando a quota no usuário
login adminftp

#### Ao executar o comando abaixo, a mensagem de quota ultrapassada é exibida
dd if=/dev/zero of=./teste bs=1M count=1500
rm teste

### Deixando um arquivo de teste de 250MB
dd if=/dev/zero of=./teste bs=1M count=250
exit

## Configurando o VSFTPD
vim /etc/vsftpd.conf

### Neste arquivo, as seguintes mudanças foram feitas
listen=YES
listen_ipv6=NO
anonymous_enable=YES
anon_root=/home/adminftp

## Após concluir a configuração do arquivo, basta reiniciar o serviço, e a máquina estará pronta para receber conexão
service vsftpd restart
service vsftpd status

# Configurando máquina - Máquina cliente

## Esta máquina tem uma placa de rede interna, esta receberá um endereço IP dentro da faixa definida no servidor DHCP, isso ocorre pois para esta máquina nenhum endereço foi especificado

## Instalando cliente FTP
apt-get update
apt-get install ftp

## Criando arquivo para tentar envia-lo ao servidor
dd if=/dev/zero of=./testeDois bs=1M count=150

## Se conectando a máquina FTP
ftp 192.168.10.252

### Dentro desta conexão testes foram feitos (Para certificar de que apenas o download é permitido)

#### Sucesso!
get teste
#### Erro
put testeDois

