# Apache

## 01. Tips

### コマンドリファレンス

#### ・httpd

参考：https://httpd.apache.org/docs/trunk/ja/programs/httpd.html

#### ・apachectl

参考：https://httpd.apache.org/docs/trunk/ja/programs/apachectl.html

<br>

### よく使うコマンド

#### ・ディレクティブの実装場所の一覧

特定のディレクティブを実装するべき設定ファイルを一覧で表示する．

```shell
$ sudo httpd -L
```

#### ・設定ファイルのバリデーション

```shell
# systemctlコマンドでは実行不可能

$ sudo service httpd configtest

$ sudo apachectl configtest

$ sudo apachectl -t
```

#### ・コンパイル済みモジュールの一覧

コンパイル済みのモジュールを一覧で表示する．表示されているからといって，読み込まれているとは限らない．

```shell
$ sudo httpd -l
```

#### ・読み込み済みモジュールの一覧

コンパイル済みのモジュールのうちで，実際に読み込まれているモジュールを表示する．

```shell
$ sudo httpd -M
```

#### ・読み込み済み```conf```ファイルの一覧

読み込まれた```conf```ファイルを一覧で表示する．この結果から，使われていない```conf```ファイルもを検出できる．

```shell
$ sudo httpd -t -D DUMP_CONFIG 2>/dev/null | grep "# In" | awk "{print $4}"
```

#### ・読み込まれるVirtualHost設定の一覧

```shell
$ sudo httpd -S
```

#### ・強制的な起動／停止／再起動

```shell
# 起動
$ sudo systemctl start httpd

# 停止
$ sudo systemctl stop httpd

# 再起動
$ sudo systemctl restart httpd
```

#### ・安全な再起動

Apacheを段階的に再起動する．安全に再起動できる．

```shell
$ sudo apachectl graceful
```

<br>

## 02. Apacheの用途

### Webサーバのミドルウェアとして

![Webサーバ，APサーバ，DBサーバ](https://raw.githubusercontent.com/hiroki-it/tech-notebook/master/images/Webサーバ，APサーバ，DBサーバ.png)

<br>

## 03. Coreにおける設定ディレクティブ

### ServerRoot

#### ・```ServerRoot```とは

他の設定ディレクティブで，相対パスが設定されている場合に適用される．そのルートディレクトリを定義する．

**＊実装例＊**

通常であれば，etcディレクトリ以下にconfファイルが配置される．

```apacheconf
ServerRoot /etc/httpd
```

CentOSのEPELリポジトリ経由でインストールした場合，Apacheのインストール後に，optディレクトリ以下にconfファイルが設置される．

```apacheconf
ServerRoot /opt/rh/httpd24/root/etc/httpd
```

<br>

### VirtualHost

#### ・```VirtualHost```とは

ディレクティブを囲うディレクティブの一つ．特定のホスト名やIPアドレスにリクエストがあった時に実行するディレクティブを定義する．VirtualHostという名前の通り，1 つのサーバ上で，仮想的に複数のドメインを扱うような処理も定義できる．複数のVirtualHostを設定した場合，一つ目がデフォルト設定として認識される．

**＊実装例＊**

```apacheconf
Listen 80
NameVirtualHost *:80

# Defaultサーバとして扱う．
<VirtualHost *:80>
    DocumentRoot /www/example1
    ServerName www.example.com
</VirtualHost>

<VirtualHost *:80>
    DocumentRoot /www/example2
    ServerName www.example.org
</VirtualHost>
```
#### ・IPベース```VirtualHost```

各ドメインに異なるIPアドレスを割り振るバーチャルホスト．

#### ・名前ベース```VirtualHost```
全てのドメインに同じIPアドレスを割り振るバーチャルホスト．

<br>

### DocumentRoot

#### ・```DocumentRoot```とは

ドキュメントのルートディレクトリを定義する．ドキュメントルートに「```index.html```」というファイルを置くと，ファイル名を指定しなくとも，ルートディレクトリ内の```index.html```ファイルが，エントリーポイントとして自動的に認識されて表示される．

**＊実装例＊**

```apacheconf
<VirtualHost *:80>
    DocumentRoot /www/example1
    ServerName www.example.com
</VirtualHost>
```

index.html以外の名前をエントリーポイントにする場合，ファイル名を指定する必要がある．

**＊実装例＊**

```apacheconf
<VirtualHost *:80>
    DocumentRoot /www/example1/start-up.html
    ServerName www.example.com
</VirtualHost>
```



### Directory

#### ・```Directory```とは

ディレクティブを囲うディレクティブの一つ．指定したディレクトリ内にリクエストがあった時に実行するディレクティブを定義する．

**＊実装例＊**

```apacheconf
<Directory "/var/www/example">
    DirectoryIndex index.php
    AllowOverride All
</Directory>
```

<br>

### User，Group

#### ・```User```とは

httpdプロセスのユーザ名を定義する．httpdプロセスによって作成されたファイルの所有者名は，このディレクティブで定義したものになる．

**＊実装例＊**

```apacheconf
User apache
```

#### ・```Group```とは

httpdプロセスのグループ名を定義する．httpdプロセスによって作成されたファイルのグループ名は，このディレクティブで定義したものになる．

**＊実装例＊**

```apacheconf
Group apache
```

<br>

### KeepAlive，MaxKeepAliveRequests，KeepAliveTimeout

#### ・```KeepAlive```とは

HTTPプロトコルのリクエストのクライアントに対して，セッションIDを付与するかどうか，を定義する．

**＊実装例＊**

```apacheconf
KeepAlive On
```

#### ・```KeepAliveTimeout```

セッションIDを付与中のクライアントにおいて，再びリクエストを送信するまでに何秒間空いたら，セッションIDを破棄するか，を定義する．

**＊実装例＊**

```apacheconf
# KeepAliveがOnの時のみ
KeepAliveTimeout 5
```

#### ・```MaxKeepAliveRequests```

セッションIDを付与中のクライアントにおいて，リクエストのファイルの最大数を定義する．

**＊実装例＊**

```apacheconf
# KeepAliveがOnの時のみ
MaxKeepAliveRequests 1000
```

<br>

## 04. mod_soにおける設定ディレクティブ

### LoadModule

#### ・LoadModule

モジュールを読み込み，設定ディレクティブを宣言できるようにする．

**＊実装例＊**

相対パスを指定し，ServerRootを適用させる．これにより，httpdディレクトリのmodulesディレクトリが参照される．

```apacheconf
# ServerRoot が /opt/rh/httpd24/root/etc/httpd だとする．

LoadModule dir_module modules/mod_dir.so
```

<br>

## 04-02. mod_dirにおける設定ディレクティブ

### DirectoryIndex

#### ・DirectoryIndexとは

Directoryディレクティブによってリクエストされたディレクトリのインデックスファイルをレスポンスする．

**＊実装例＊**

```apacheconf
<Directory "/var/www/example">
    DirectoryIndex index.html index.php
</Directory>
```
**＊実装例＊**

```apacheconf
<Directory "/var/www/example">
    DirectoryIndex index.html
    DirectoryIndex index.php
</Directory>
```

<br>

### AllowOverride

#### ・```AllowOverride```とは

別に用意した```.htaccess```ファイルにて，有効化するディレクティブを定義する．

**＊実装例＊**

```apacheconf
<Directory "/var/www/example">
    DirectoryIndex index.php
    AllowOverride All
</Directory>
```

#### ・```All```

別に用意した```.htaccess```ファイルにて，実装可能なディレクティブを全て有効化する．

**＊実装例＊**

```apacheconf
AllowOverride All
```

#### ・```None```

別に用意した```.htaccess```ファイルにて，実装可能なディレクティブを全て無効化する．

**＊実装例＊**

```apacheconf
AllowOverride None
```

#### ・```Indexes```

別に用意した```.htaccess```ファイルにて，DirectoryIndexディレクティブを有効化する．

**＊実装例＊**

```apacheconf
AllowOverride Indexes
```

<br>

## 04-03. mod_writeにおける設定ディレクティブ

### RewriteCond

#### ・```RewriteCond```とは

条件分岐と，それによる処理を定義する．

**＊実装例＊**

```apacheconf
RewriteCond %変数名 条件
```

**＊実装例＊**

```apacheconf
RewriteCond %{HTTP:X-Forwarded-Port} !^443$
```

<br>

### RewriteRule

#### ・リダイレクトとリライトの違い

リダイレクトでは，リクエストされたURLをサーバ側で新しいURLに書き換え，リクエストを再送信する．そのため，クライアント側は新しいURLで改めてリクエストを送信することになる．一方で，リライトでは，リクエストされたURLをサーバ側で新しいURLに書き換え，そのURLでレンダリングを行う．そのため，クライアント側は古いURLのままリクエストを送信することになる．その他の違いについては，以下を参考にせよ．

参考：https://blogs.iis.net/owscott/url-rewrite-vs-redirect-what-s-the-difference

#### ・```RewriteRule```とは

条件分岐による処理を定義する．

```apacheconf
RewriteRule URL書換＆転送の記述
```

**＊実装例＊**

リクエストをHTTPSプロトコルに変換して，リダイレクトする．

```apacheconf
RewriteRule ^(.*)?$ https://%{HTTP_HOST}$1 [R=301,L]
```

<br>

## 04-04. mod_setenvifにおける設定ディレクティブ

### SetEnvIf

#### ・```SetEnvIf```とは

条件分岐と環境変数の設定を定義する．

```apacheconf
# クエリパラメータが以下の拡張子の場合に，
SetEnvIf Request_URI "\.(gif|jpe?g|png|js|css)$" object-is-ignore
```

#### ・nolog

ログを出力しない場合を設定できる．

<br>

## 04-05. mod_log_configにおける設定ディレクティブ

### LogFormat

#### ・```LogFormat```とは

アクセスログファイルの書式を定義する．

#### ・アクセスログ形式と出力内容

アクセスログの出力先ログファイルとフォーマットを合わせて定義する．

**＊実装例＊**

```apacheconf
# common形式
CustomLog logs/access_log common
LogFormat "%h %l %u %t "%r" %>s %b" common

# combine形式
CustomLog logs/access_log combined
LogFormat "%h %l %u %t "%r" %>s %b "%{Referer}i" "%{User-Agent}i"" combined
```

以下のようなログになる．

```
# common形式
118.86.194.71 - - [17/Aug/2011:23:04:03 +0900] "GET /home/name/category/web HTTP/1.1" 200 11815

# combine形式
118.86.194.71 - - [17/Aug/2011:23:04:03 +0900] "GET /home/name/category/web HTTP/1.1" 200 11815 "http://naoberry.com/home/name/" "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.112 Safari/535.1"
```

#### ・ログの変数一覧

| 変数           | 値                                  | 例                                                           |
| -------------- | ----------------------------------- | ------------------------------------------------------------ |
| %h             | リモートホスト                      | 118.86.194.71                                                |
| %l             | リモートログ名（基本”-“になる）     | -                                                            |
| %u             | リモートユーザ（Basic認証のユーザ） | -                                                            |
| %t             | リクエスト受付時刻                  | [17/Aug/2011:23:04:03 +0900]                                 |
| %r             | リクエストの最初の行                | GET /home/name/category/web HTTP/1.1                         |
| %s             | ステータス                          | 200                                                          |
| %b             | レスポンスのバイト数                | 11815                                                        |
| %{Referer}i    | リファラ                            | http://naoberry.com/home/name/                               |
| %{User-Agent}i | ユーザエージェント                  | Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.112 Safari/535.1 |

<br>

### ErrorLog

#### ・```ErrorLog```とは

エラーログファイルの書式を定義する．

#### ・エラーログ形式と出力内容

エラーログの出力先を定義する．

**＊実装例＊**

```apacheconf
ErrorLog /var/log/httpd/error_log
```

<br>

### LogLevel

#### ・```LogLevel```とは

どのレベルまでログを出力するかを定義する．

| ログレベル | 意味                                   | 設定の目安       |
| ---------- | -------------------------------------- | ---------------- |
| emerg      | サーバが稼動できないほどの重大なエラー |                  |
| alert      | critよりも重大なエラー                 |                  |
| crit       | 重大なエラー                           |                  |
| error      | エラー                                 |                  |
| warn       | 警告                                   | 本番環境         |
| notice     | 通知メッセージ                         |                  |
| info       | サーバ情報                             | ステージング環境 |
| debug      | デバック用の情報                       |                  |

<br>

## 04-06. mod_sslにおける設定ディレクティブ 

### SSLCertificateFile

#### ・```SSLCertificateFile```とは

PKIにおける公開鍵の検証に必要なSSLサーバ証明書のディレクトリを定義する．本番環境ではAWSのACM証明書を用いることが多いため，基本的な用途としては，ローカル開発でのオレオレ証明書読み込みのために用いる．

**＊実装例＊**

```apacheconf
SSLCertificateFile /etc/httpd/conf.d/server.crt
```

<br>

### SSLCertificateKeyFile

#### ・```SSLCertificateKeyFile```とは

PKIにおける公開鍵の検証に必要な秘密鍵のディレクトリを定義する．

**＊実装例＊**

```apacheconf
SSLCertificateKeyFile /etc/httpd/conf.d/server.key
```

<br>

## 04-07. mod_headersにおける設定ディレクティブ

### Header

#### ・```Header```とは

レスポンスヘッダーを定義する．```set```，```append```，```add```，```unset```，```echo```オプションを設定できる．標準では```2xx```と```3xx```のステータスコードのみで設定が適用される．オプションとして，```always```を設定することで，全てのステータスコードでヘッダーを設定する．

#### ・```set```

レスポンスヘッダーを追加する．

**＊実装例＊**

Referrer-Policyヘッダーを追加し，値を```no-referrer-when-downgrade```とする．ちなみに，Chrome85以降のReferrer-Policyヘッダー初期値の仕様変更については，以下を参考にせよ．

参考：https://www.chromestatus.com/feature/6251880185331712

```apacheconf
Header set Referrer-Policy "no-referrer-when-downgrade"
```

```apacheconf
Header set Referrer-Policy "no-referrer-when-downgrade" always
```

#### ・```unset```

レスポンスヘッダーを削除する．

**＊実装例＊**

Referrer-Policyヘッダーを削除する

```apacheconf
Header unset Referrer-Policy "no-referrer-when-downgrade
```

```apacheconf
Header unset Referrer-Policy "no-referrer-when-downgrade" always
```

<br>

## 05. htaccess

### 影響範囲

#### ・ルートディレクトリの場合

全てのファイルに対して，ディレクティブが適用される．

![htaccess影響範囲](https://raw.githubusercontent.com/hiroki-it/tech-notebook/master/images/htaccess影響範囲.png)

#### ・それ以外のディレクトリの場合

設置したディレクトリ以下の階層のファイルに対して適用される．

![htaccess影響範囲_2](https://raw.githubusercontent.com/hiroki-it/tech-notebook/master/images/htaccess影響範囲_2.png)

