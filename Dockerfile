FROM rdxmaster/crontab:latest

RUN apt-get install -y lftp

# Add crontab file in the cron directory
ADD simple-crontab /etc/cron.d/simple-crontab

# Add shell script and grant execution rights
ADD script.sh /script.sh
RUN chmod +x /script.sh

# Add shell script and grant execution rights
ADD env.sh /env.sh
RUN chmod +x /env.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/simple-crontab

