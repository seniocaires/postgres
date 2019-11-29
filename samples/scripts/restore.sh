#!/bin/bash

read -p 'Digite o nome do arquivo de backup que deseja restaurar: ' ARQUIVO

sudo cp backups/${ARQUIVO} backups/restore.dump

docker exec -it #ambiente#_db_1 bash -c "cd /backups && psql -U postgres -f restore.dump"

sudo rm -rf backups/restore.dump
