FROM ubuntu:16.04

# 必要なパッケージインストール
RUN apt-get update && apt-get install -y supervisor cron mysql-client tzdata rsyslog

# タイムゾーン変更
RUN /usr/sbin/dpkg-reconfigure -f noninteractive tzdata

# supervisorの設定
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# rsyslogの設定
COPY 50-default.conf /etc/rsyslog.d/50-default.conf

# cron読み込み
COPY crontab.root /var/spool/cron/crontabs/root
RUN crontab /var/spool/cron/crontabs/root

CMD ["/usr/bin/supervisord"]
