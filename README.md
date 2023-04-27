# 使い方

## 起動
```
docker-compose up -d
```

## サンプルサイトの立ち上げ
```
docker exec php bash /var/www/tools/setup-wp.sh sample
```

## hostsに以下を定義する
```
127.0.0.1 sample.wp.test
```
*簡易DNSサーバ（dnsmasqコンテナ）も起動しているので、それを使ってもOK。
*dnsmasqを使えば同一WiFiに接続したスマホからアクセスも可能。その場合はdnsmasqでのIPアドレス定義を「127.0.0.1」ではなく端末のIPアドレスに変更する。

## サンプルサイトにアクセスし、WordPressサイトが表示されることを確認する
```
https://sample.wp.test
```



