# 1 - Na pasta home do seu usuário, crie 3 arquivos de texto e para cada arquivo crie um softlink e um hardlink. Você define o nome de cada arquivo e link criado.

## Criando os arquivos
> arquivoOne ; > arquivoTwo ; > arquivoThree

## Criando diretório onde os hardlinks irão ficar
mkdir links

## Fazendo softlink
ln -s arquivoOne linkOne
ln -s arquivoTwo linkTwo
ln -s arquivoThree linkThree

## Criando hardlink
ln arquivoOne links/linkOneHard
ln arquivoTwo links/linkTwoHard
ln arquivoThree links/linkThreeHard

# 2 - Mova todo hardlink par a fora da pasta home . Após isso troque altere a permissão da pasta home do seu usuário para ninguém mais tenha acesso a ela

mv links/*Hard /tmp/

# Mudando permissão
cd ..
chmod 700 felipe/


# 3 - Faça login co m outro usuário e tente acessar os arqu ivos, que estão n a pasta ho me , sem permissão de acesso, usando cada hardlink .
## Para mudar de usuário utilizei as seguintes teclas Alt + Seta para a esquerda
## Entrei no usuário user6

cd /tmp/
cat linkOneHard
cat linkTwoHard
cat linkThreeHard

## Utilizando vim
vim linkOneHard
vim linkTwoHard
vim linkThreeHard

## Ao fazer o teste eu consigo ler o arquivo porém não consigo escrever. E isso vale para todos os arquivos
## Para realizar a confirmação, fui até o usuário e escrevi alguns textos dentro de cada arquivo, e assim confirmei que ele fica apenas leitura.

# 4 - Libere acesso a pasta home que estava bloqueada e para cada a rquivo, que possui um softlink, bloquei seu acesso exceto para o dono.

## Voltando para o usuário 'felipe'. Dentro de sua home usei os comandos
cd ..
chmod g+xr,o+rx felipe

## Bloquando acesso
cd felipe
chmod g-r,o-r arquivo*

# 5 - Tente acessar agora cada arquivo , com acesso bloqueado, através do seu softlink.

## Voltando para o usuário 'user6' 

cd /home/felipe

## Tentando acessar os arquivos. Todas as permissões foram negadas, dando permissão apenas para o proprietário, mesmo no softlink
cat linkOne
cat linkTwo
cat linkThree

vim linkOne
vim linkTwo
vim linkThree

# 6 - Faça uma busca por todos os arquivos, que tem hardlink, utilizando o inode.
## Listo as informações de cada arquivo no home do usuário 'felipe'
stat arquivo* | grep Links

## Com isso verifico quais arquivos tem mais de 1 link, e faço a busca por eles
find -inum 4980759
find -inum 4980761
find -inum 4980760
