#!/bin/sh
set -e
if [ -z "$RESTIC_FILE_LIST" ]; then
    sed -i 's/backup \/data/backup %(ENV_RESTIC_FILE_LIST)s/' /etc/supervisor.d/restic.ini
fi
echo "${CRON_BACKUP_EXPRESSION} supervisorctl start restic_backup" | crontab -
crontab -l | { cat; echo "${CRON_CLEANUP_EXPRESSION} supervisorctl start restic_cleanup"; } | crontab -
/usr/sbin/crond -f

