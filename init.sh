#!/bin/sh

clear

echo "==============================================================================================================="
echo "==  ATENÇÃO:                                                                                                 =="
echo "==  Este script irá configurar o serviço do postgres para você.                                              =="
echo "==============================================================================================================="
sleep 2

echo ":.:.:.:.:.:.:> PRÉ-CONFIGURAÇÃO <:.:.:.:.:.:.:."
echo "Restaurando configuração do docker-compose"
cat samples/docker-compose/docker-compose.yml > docker-compose.yml
echo "Restaurando configuração do backup"
cat samples/scripts/dump.sh > dump.sh
cat samples/scripts/restore.sh > restore.sh


read -p 'Digite qual será o nome do AMBIENTE: ' AMBIENTE
read -p 'Digite qual será a PORTA usada pelo Postgres: ' PORTA
read -p 'Digite qual será a SENHA do Postgres: ' SENHA

PORTA='      - "'${PORTA}':5432"'
SENHA='      POSTGRES_PASSWORD: '${SENHA}

echo "Configurando arquivo docker-compose.yml"
sed -i "s/#porta#/$PORTA/g" docker-compose.yml
sed -i "s/#senha#/$SENHA/g" docker-compose.yml

echo ""  >> docker-compose.yml
echo "# Iniciar o ambiente" >> docker-compose.yml
echo "# docker-compose -p "${AMBIENTE}" up -d " >> docker-compose.yml
echo ""  >> docker-compose.yml
echo "# Remover o ambiente"  >> docker-compose.yml
echo "# docker-compose down"  >> docker-compose.yml


echo "Configurando arquivo dump.sh"
sed -i "s/#ambiente#/$AMBIENTE/g" dump.sh

echo "Configurando arquivo restore.sh"
sed -i "s/#ambiente#/$AMBIENTE/g" restore.sh


echo "Configuração completa."
echo "Execute o comando abaixo para iniciar o ambiente"

echo ".................................................................."
echo "docker-compose -p "${AMBIENTE}" up -d "
echo ".................................................................."
