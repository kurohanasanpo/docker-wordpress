# 使い方

1. 起動
```
docker-compose up -d
```

2. サンプルサイトの立ち上げ
```
docker exec php bash /var/www/tools/setup-wp.sh sample
```

3. hostsに以下を定義する
```
127.0.0.1 sample.wp.test
```
※簡易DNSサーバ（dnsmasqコンテナ）も起動しているので、それを使ってもOK。

4. サンプルサイトにアクセスし、WordPressサイトが表示されることを確認する
https://sample.wp.test




