# コンテナオーケストレーション

## 01. コンテナオーケストレーションの種類

### 単一ホストOS上のコンテナオーケストレーション

単一ホストOS上のコンテナが対象である．異なるDockerfileに基づいて，Dockerイメージのビルド，コンテナレイヤーの生成，コンテナの構築，コンテナの起動，を実行できる．

| ツール名       | ベンダー |
| -------------- | -------- |
| Docker Compose | Docker   |



### 複数ホストOSに渡るコンテナオーケストレーション

複数ホストOS上のコンテナが対象である．どのホストOSのDockerデーモンに対して，どのコンテナに関する操作を行うのかを選択的に命令できる．

| ツール名                      | ベンダー |
| ----------------------------- | -------- |
| Docker Swarm                  | Docker   |
| Google Kubernetes             | Google   |
| AWS Elastic Container Service | Amazon   |



## 02. Docker Compose

### docker-compose.yml

#### ・```container_name```

コンテナ名の命名．

**【実装例】**

```yaml
container_name: www
```

#### ・```build: dockerfile```

Dockerfileの名前．パスごと指定する．

**【実装例】**

```yaml
build:
  dockerfile: ./infra/docker/www/Dockerfile
```

#### ・```build: target```

ビルドするステージ名．主に，マルチステージビルドの時に使用する．

**【実装例】**

```yaml
build:
  target: develop
```

#### ・```build: context```

指定したDockerfileのあるディレクトリをカレントディレクトリとして，Dockerデーモン（Dockerエンジン）に送信するディレクトリを指定する． 

**【実装例】**

```yaml
build:
  context: .
```

#### ・```tty```

```docker exec -it```に相当する．対話モードで接続することによって，```exit```の後もコンテナを起動させ続けられる．

**【実装例】**

```yaml
tty: true
```



#### ・```image```

**【実装例】**

```yaml
image: tech-notebook-www:{タグ名}
```


#### ・```ports```

ホストOSとコンテナの間のポートフォワーディングを設定．コンテナのみポート番号を指定した場合，ホストOS側のポート番号はランダムになる．

**【実装例】**

```yaml
ports:
  - "8080:80" # {ホストOS側のポート番号}:{コンテナのポート番号}
```

#### ・```volumes```

ホストOSの```/var/lib/docker/volumes/```の下にDataVolumeのディレクトリを作成し，DataVolumeをマウントするコンテナ側のディレクトリをマッピング．

**【実装例】**


```yaml
volumes:
  - ./app:/var/www/app # {ホストOSのディレクトリ}:{コンテナのディレクトリ}
```

#### ・```environment```

DBコンテナに設定する環境変数．

**【実装例】**

```yaml
environment:
  MYSQL_ROOT_PASSWORD: xxxxx # Rootパス
  MYSQL_DATABASE: example # データベース名
  MYSQL_USER: example_user # ユーザ名
  MYSQL_PASSWORD: xxxxx # ユーザパス
```


#### ・```depends_on```

コンテナが起動する順番．

**【実装例】**

```yaml
# ここに実装例
```

#### ・```networks```

作成使用する内部／外部ネットワークを設定．

![Dockerエンジン内の仮想ネットワーク](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/images/Dockerエンジン内の仮想ネットワーク.jpg)

**【実装例】**

バックエンドとフロントエンドが異なるdocker composeで管理されており，フロントエンドコンテナからバックエンドコンテナに接続する．

```yaml
# バックエンドのDocker-compose
services:
  app:
    container_name: backend-container
    
# --- 省略 --- #
    
networks:
  backend: # 作成したい外部ネットワーク
    external: true  
```

```yaml
# フロントエンドのDocker-compose
services:
  app:
    container_name: frontend-container
    networks: # 接続した内部／外部ネットワークのいずれかを選択．
      - default
      - backend

# --- 省略 --- #

networks:
  default:
    external:
      name: backend # 接続したい外部ネットワーク
```

作成した内部／外部ネットワークは，以下のコマンドで確認できる．```xxx_default```という名前になる．

```bash
$ docker network ls

NETWORK ID       NAME                      DRIVER       SCOPE
xxxxxxxxxxxx     backend_default           bridge       local
xxxxxxxxxxxx     {プロジェクト名}_default     bridge      local
```



### ```docker-compose```コマンド

#### ・```up```

すでに起動中／停止中コンテナがある場合，それをデタッチドモードで再起動する．

```bash
# イメージのビルド，コンテナレイヤー生成，コンテナ構築，コンテナ起動
$ docker-compose up -d
```

#### ・```run```

すでに起動中／停止中コンテナがあっても，それを残して新しいコンテナを構築し，デタッチドモードで起動する．古いコンテナが削除されずに残ってしまう．

```bash
# イメージのビルド，コンテナレイヤー生成，コンテナ構築，コンテナ起動 
$ docker-compose run -d -it {イメージ名}
```



## 03. Docker Swarm

![DockerSwarmの仕組み](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/images/DockerSwarmの仕組み.png)



## 04. Google Kubernetes

![Kubernetesの仕組み](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/images/Kubernetesの仕組み.png)

### Node

#### ・Master Node

Kubernetesが実行される物理サーバを指す．

#### ・Worker Node

Dockerが実行される仮想サーバを指す．



### Pod

#### ・Podとは

仮想サーバのホストOS上のコンテナをグループ化したもの．

#### ・Secret

セキュリティに関するデータを管理し，コンテナに選択的に提供するもの．

#### ・Replica Set（Replication Controller）

#### ・Kubectl
