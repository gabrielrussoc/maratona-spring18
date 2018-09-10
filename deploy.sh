#!/bin/bash

## O QUE ESSE SCRIPT FAZ
# Publica o site no usuario da maratona em ime.usp.br/~maratona/spring18

## ANTES DE USAR O SCRIPT
# Cheque se você tem rsync na sua máquina local e na rede IME (acho que tem por padrão na rede IME)
# Tenha certeza que o seu usuário consegue acessar o usuario da maratona (rode sudo -u maratona -i)
# É necessário Jekyll e Git

echo -e "\033[0;32m[Insira um usuário válido da Rede IME com acesso ao usuário da maratona (exemplo: usuario)]\033[0m"
read USER
DEST=/home/gradmac/$USER/_temp_spring18/

USER=$USER@ime.usp.br

# Atualiza o repo
echo -e "\033[0;32m[Sincronizando o site com o GitHub]\033[0m"
git pull origin master

# Build
echo -e "\033[0;32m[Buildando com jekyll]\033[0m"
jekyll build

# Envia o arquivo pro usuário
echo -e "\033[0;32m[Enviando arquivos para a rede IME]\033[0m"
rsync _site/ $USER:$DEST -r

# Envia o arquivo para o servidor final
echo -e "\033[0;32m[Copiando arquivos para o usuario da maratona]\033[0m"
ssh $USER "sudo -u maratona rsync $DEST /home/specmac/maratona/www/winter18 -r"
