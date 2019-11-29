#!/bin/bash
 
docker exec -it #ambiente#_db_1 bash -c "cd /backups && pg_dumpall -U postgres -h localhost --clean --file=backup.dump"
sudo mv backups/backup.dump backups/backup-$(date +%Y-%m-%d-%H-%M).dump

