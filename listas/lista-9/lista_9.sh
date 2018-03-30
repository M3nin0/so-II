# Lista 9

# 1 - Crie tr�s diret�rios, e em cada um deles tr�s arquivos de texto, dentro do diret�rio /var.

## Acessando root
su

## Criando os arquivos

mkdir /var/dirOne && > /var/dirOne/fileOne ; > /var/dirOne/fileTwo ; > /var/dirOne/fileThree

mkdir /var/dirTwo && > /var/dirTwo/fileOne ; > /var/dirTwo/fileTwo ; > /var/dirTwo/fileThree

mkdir /var/dirThree && > /var/dirThree/fileOne ; > /var/dirThree/fileTwo ; > /var/dirThree/fileThree

# 2 - Agora voc� deve criar uma ou mais rotinas de backup. As rotinas devem funcionar a cada 2 minutos. Deve-se compactar as tr�s pastas em um �nico arquivo tarball.

## A cada dois m�nutos executa a rotina

crontab -e

*/2 * * * * tar -cvzf pacotesDir.tar.gz /var/dir*

## Confirmando

crontab -l


# 3 - Ap�s  a  compacta��o  cada  arquivo  dever�  ser  copiado  para dentro da  pasta home de cada usu�rio existente no sistema.

## Ainda com o usu�rio root

cd

## Espera os dois minutos iniciais

cp pacotesDir.tar.gz /home/user1
cp pacotesDir.tar.gz /home/user6
cp pacotesDir.tar.gz /home/user7


# 4 - Por �ltimo, as rotinas devem enviar o arquivo compactado, via ssh, para um colega de sua escolha.
## Este exerc�cio fiz utilizando uma m�quina real e uma VM. O envio ser� da VM, para a m�quina real.

## Ainda no root

crontab -e

*/2 * * * * scp pacotesDir.tar.gz felipe@192.168.0.17:/home/felipe

# 5 - Ap�s receber os arquivos, deve-se descompact�-los dentro da pasta /var. Todo processo deve ser feito por usu�rios que n�o o usu�rio root. Para isso uma outra rotina na m�quina que ir� receber os arquivos dever� ser criada realizando o processa de extra��o dos arquivos. Perceba que ser� necess�rio realizar isso em sincronia.
# 6 - As rotinas devem funcionar assim que o sistema for ligado ou desligado.

O exerc�cio 5 e 6 devem ficar juntos ? Fiz junto. Tirar d�vida com o professor.

## Na m�quina que recebeu o arquivo

crontab -e

## Criando agendamento

@reboot tar -xvzf /home/felipe/pacotesDir.tar.gz -C var/
