# Lista 9

# 1 - Crie três diretórios, e em cada um deles três arquivos de texto, dentro do diretório /var.

## Acessando root
su

## Criando os arquivos

mkdir /var/dirOne && > /var/dirOne/fileOne ; > /var/dirOne/fileTwo ; > /var/dirOne/fileThree

mkdir /var/dirTwo && > /var/dirTwo/fileOne ; > /var/dirTwo/fileTwo ; > /var/dirTwo/fileThree

mkdir /var/dirThree && > /var/dirThree/fileOne ; > /var/dirThree/fileTwo ; > /var/dirThree/fileThree

# 2 - Agora você deve criar uma ou mais rotinas de backup. As rotinas devem funcionar a cada 2 minutos. Deve-se compactar as três pastas em um único arquivo tarball.

## A cada dois mínutos executa a rotina

crontab -e

*/2 * * * * tar -cvzf pacotesDir.tar.gz /var/dir*

## Confirmando

crontab -l


# 3 - Após  a  compactação  cada  arquivo  deverá  ser  copiado  para dentro da  pasta home de cada usuário existente no sistema.

## Ainda com o usuário root

cd

## Espera os dois minutos iniciais

cp pacotesDir.tar.gz /home/user1
cp pacotesDir.tar.gz /home/user6
cp pacotesDir.tar.gz /home/user7


# 4 - Por último, as rotinas devem enviar o arquivo compactado, via ssh, para um colega de sua escolha.
## Este exercício fiz utilizando uma máquina real e uma VM. O envio será da VM, para a máquina real.

## Ainda no root

crontab -e

*/2 * * * * scp pacotesDir.tar.gz felipe@192.168.0.17:/home/felipe

# 5 - Após receber os arquivos, deve-se descompactá-los dentro da pasta /var. Todo processo deve ser feito por usuários que não o usuário root. Para isso uma outra rotina na máquina que irá receber os arquivos deverá ser criada realizando o processa de extração dos arquivos. Perceba que será necessário realizar isso em sincronia.
# 6 - As rotinas devem funcionar assim que o sistema for ligado ou desligado.

O exercício 5 e 6 devem ficar juntos ? Fiz junto. Tirar dúvida com o professor.

## Na máquina que recebeu o arquivo

crontab -e

## Criando agendamento

@reboot tar -xvzf /home/felipe/pacotesDir.tar.gz -C var/
