# ビルド，テスト，AWSへのデプロイの流れ

## 01-01. オンプレミスとクラウドコンピューティングの種類

ベンダーが，システムを稼働させるために必要なソフトウェアとハードウェアをどこまで提供するかによって，サービスの名称が異なる．

![オンプレ，ホスティング，IaaS，CaaS，PaaS，Faas，SaaSの比較.png](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/オンプレ，ホスティング，IaaS，CaaS，PaaS，Faas，SaaSの比較.png)



### :pushpin: On premise

ベンダーは関わらず，ユーザの設備によって，システムを運用すること．



### :pushpin: IaaS：Infrastructure as a Service

**【Iaasアプリ例】**

Amazon Web Service，Google Cloud Platform，Microsoft Azure，IBM Cloud



### :pushpin: PaaS：Platform as a Service

**【Paasアプリ例】**

Google App Engine，Windows Azure



### :pushpin: FaaS：Platform as a Service

ユーザ側は関数プログラムの実装のみを行い，それ以外はベンダー側に管理してもらうサービスのこと．

**【サービス例】**

Lambda



### :pushpin: SaaS：Software as a Service

従来はパッケージとして提供していたアプリケーションを，Webアプリケーションとして提供するサービスのこと．

**【サービス例】**

Google Apps（Google Map，Google Cloud，Google Calender など）



## 02-01. CI/CDの流れ

### :pushpin: CI：Continuous Integration，CD：Continuous Deliveryとは

Code > Build > Test > Code > Build > Test ・・・ のサイクルを高速に回して，システムの品質を継続的に担保することを，『Continuous Integration』という．また，変更内容をステージング環境などに自動的に反映し，継続的にリリースすることを，『Continuous Delivery』という．

![cicdツールの種類](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/cicdツールの種類.png)



### :pushpin: CIツールによるビルドフェイズとテストフェイズの自動実行

#### ・PHPUnitの自動実行

1. テストクラスを実装したうえで，新機能を設計実装する．

2. リポジトリへPushすると，CIツールがGituHubからブランチの状態を取得する．

3. CIツールによって，テストサーバの仮想化，インタプリタ，PHPUnitなどが自動実行される．

4. 結果を通知することも可能．

![継続的インテグレーション](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/継続的インテグレーション.png)

#### ・PHPStanの自動実行



### :pushpin: CDツールによるデプロイフェイズの自動実行

#### ・クラウドデプロイサーバにおけるCapisoranoによるデプロイ

1. クラウドデプロイサーバからクラウドWebサーバにリモート接続する．

![デプロイサーバからインスタンスへのデプロイ.png](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/デプロイサーバからインスタンスへのデプロイ.png)

2. 本番環境（ここではクラウドWebサーバ）にインストールしておいたGitで，```pull```あるいは```clone```を実行し，GitHubからクラウドデプロイサーバにmasterブランチの状態を取り込む．

![GitHub上のコードが本番環境にデプロイされるまで](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/GitHub上のコードが本番環境にデプロイされるまで.png)

3. これらの手順を自動デプロイツール（例：Capistrano）が行う．クラウドデプロイサーバに自動デプロイツールを配置する．自動デプロイツールがクラウドWebサーバやDBサーバにリモート接続し，```pull```や```clone```を実行する．

![Capistranoを用いた自動デプロイ](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/Capistranoを用いた自動デプロイ.png)



#### ・AWS CodeDeployによるデプロイ

![CodeDeployを用いた自動デプロイ](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/CodeDeployを用いた自動デプロイ.png)



## 03-01. AWSにおけるグローバルネットワーク構成

AWSから，グローバルIPアドレスと完全修飾ドメイン名が提供され，Webサービスがリリースされる．

### :pushpin: クラウドデザイン例

以下のデザイン例では，Dualシステムが採用されている．

![AWSのクラウドデザイン一例](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/AWSのクラウドデザイン一例.png)



### :pushpin: Route 53（＝DNSサーバ）

クラウドDNSサーバーとして働く．リクエストされた完全修飾ドメイン名とインスタンスのグローバルIPアドレスをマッピングしている．



### :pushpin: CloudFront（＝プロキシサーバ）

クラウドプロキシサーバとして働く．Amazon S3へのアクセスをキャッシングする．



### :pushpin: CloudTrail

IAMユーザによる操作や，ロールのアタッチの履歴を記録し，ログファイルとしてS3に転送する．CloudWatchと連携することもできる．

![CloudTrailとは](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/CloudTrailとは.jpeg)



### :pushpin: S3：Simple Storage Service（＝外付けストレージ）

クラウド外付けストレージとして働く．Amazon S3に保存するCSSファイルや画像ファイルを管理できる．



### :pushpin: API Gateway

API Gatewayは，メソッドリクエスト，統合リクエスト，統合レスポンス，メソッドレスポンス，から構成される．

![APIGatewayの仕組み](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/APIGatewayの仕組み.png)

1. メソッドリクエストで，クライアントからリクエストメッセージを受信．また，これからデータを抽出．（※メッセージについては，アプリケーション層の説明を参照せよke）
2. 統合リクエストで，データを編集し，指定のAWSサービスにこれを送信．
3. 統合レスポンスで，指定のAWSサービスからデータを受信し，これを編集．
4. メソッドレスポンスで，HTTPステータスを追加．また，データをレスポンスメッセージとして，クライアントに送信．



### :pushpin: SQS：Amazon Simple Queue Service

クラウドメッセージキューとして働く．異なるVPC間でも，メッセージキューを同期できる．クラウドサーバで生成されたメッセージは，一旦SQSに追加される．コマンドによってバッチが実行され，メッセージが取り出される．その後，例えば，バッチ処理によってメッセージからデータが取り出されてファイルが生成され，S3に保存されるような処理が続く．スタンダード方式キューとFIFO方式：First In First Outキューがある．

![AmazonSQSとは](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/AmazonSQSとは.jpeg)

### :pushpin: Lambdaと他FaaSの連携によるサーバレスアーキテクチャ

Lambdaを軸に他のFaaSと連携させることによって，ユーザ側は関数プログラムを作成しさえすれば，これを実行することができる．この方法を，『サーバレスアーキテクチャ』という．

![サーバレスアーキテクチャとは](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/サーバレスアーキテクチャとは.png)



### :pushpin: CloudWatch系

#### ・Cloud Watch Logs（＝ログ収集サーバに相当）

AWSの各種サービスで生成されたログファイルを収集できる．

#### ・Cloud Watch Events

イベントやスケジュールを検知し，指定したアクションを行う．

| イベント例                | スケジュール例       |      | アクション例              |
| ------------------------- | -------------------- | ---- | ------------------------- |
| APIのコール               | Cron形式での日時指定 | ⇒    | Lambdaによる関数の実行    |
| AWSコンソールへのログイン |                      | ⇒    | SQSによるメッセージの格納 |
| インスタンスの状態変化    |                      | ⇒    | SNSによるメール通知       |
| ...                       | ...                  | ⇒    | ...                       |



## 03-02. AWSにおけるプライベートネットワーク構成

### :pushpin: クラウドデザイン例（再掲）

![AWSのクラウドデザイン一例](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/AWSのクラウドデザイン一例.png)



### :pushpin: セキュリティグループ（＝パケットフィルタリング型ファイアウォール）

クラウドパケットフィルタリング型ファイアウォールとして働く．インバウンド（受信ルール）では，プロトコルや受信元IPアドレスを設定でき，アウトバウンド（送信ルール）では，プロトコルや送信先プロトコルを設定できる．

#### ・パケットフィルタリング型ファイアウォールとは（セキュリティのノートを参照せよ）

パケットのヘッダ情報に記載された送信元IPアドレスやポート番号などによって，パケットを許可するべきかどうかを決定する．速度を重視する場合はこちら．ファイアウォールとWebサーバの間には，NATルータやNAPTルータが設置されている．これらによる送信元プライベートIPアドレスから送信元グローバルIPアドレスへの変換についても参照せよ．

![パケットフィルタリング](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/パケットフィルタリング.gif)



### :pushpin: VPC：Virtual Private Cloud（＝プライベートネットワーク）

クラウドプライベートネットワークとして働く．プライベートIPアドレスが割り当てられた，VPCと呼ばれるプライベートネットワークを仮想的に構築することができる．異なるAvailability Zoneに渡ってkクラウドWebサーバを立ち上げることによって，クラウドサーバをデュアル化することできる．

![VPCが提供できるネットワークの範囲](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/VPCが提供できるネットワークの範囲.png)



### :pushpin: VPCエンドポイント

NATとインターネットゲートウェイを経由せずにVPCの外側と通信できるため，NATの負荷を抑え，またより安全に通信できる．

![VPCエンドポイント](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/VPCエンドポイント.png)



### :pushpin: ELB：Elastic Load Balancing

デュアル化させたインスタンスへのアクセスを自動的に分配し，サーバへの負荷を緩和するサービス．機能別に，NLB：Network Load Balancer，ALB：Application Load Balancer，CLB：Classic Load Balancer，の3種類に分類できる．



### :pushpin: RegionとAvailability Zone

2016年1月6日時点では，以下のRegionに物理サーバのデータセンターがある．さらに，各データセンターは物理的に独立したAvailability Zoneというロケーションから構成されている．東京Regionには，3つのAvailability Zoneがある．AZの中に，VPC subnetを作ることができ，そこにクラウドWebサーバを構築できる．

![AWSリージョンマップ](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/AWSリージョンマップ.PNG)



### :pushpin: Internet Gateway，NAT Gateway


|              |                       Internet Gateway                       |   NAT Gateway   |
| :----------: | :----------------------------------------------------------: | :-------------: |
|   **機能**   | グローバルネットワークとプライベートネットワーク間（ここではVPC）におけるNAT（静的NAT） | NAPT（動的NAT） |
| **設置場所** |                            VPC上                             | Public subnet内 |

#### ・Internet Gatewayとは

グローバルネットワークとプライベートネットワーク間（ここではVPC）におけるNAT（静的NAT）の機能を持つ．一つのPublic IPに対して，一つのクラウドWebサーバのPrivate IPを紐づけられる．詳しくは，NAT（静的NAT）を参照せよ．

#### ・NAT Gatewayとは

NAPT（動的NAT）の機能を持つ．一つのPublic IPに対して，複数のクラウドWebサーバのPrivate IPを紐づけられる．詳しくは，NAPT（動的NAT）を参照せよ．

![InternetGatewayとNATGateway](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/InternetGatewayとNATGateway.png)




### :pushpin: VPC subnet

クラウドプライベートネットワークにおけるセグメントとして働く．

#### ・Public subnetとは

非武装地帯に相当し，クラウドWebサーバが構築される．攻撃の影響が内部ネットワークに広がる可能性を防ぐために，外部から直接リクエストを受ける，

#### ・Private subnetとは

内部ネットワークに相当し，Amazon Aurora（クラウドデータベース）などが構築される．外部から直接リクエストを受けずにレスポンスを返せるように，プライベートサブネット内のNATを経由させる必要がある．

![パブリックサブネットとプライベートサブネットの設計](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/パブリックサブネットとプライベートサブネットの設計.png)



### :pushpin: Route Table = マッピングテーブルに相当

クラウドルータのマッピングテーブルとして働く．ルータについては，NATとNAPTを参照せよ．

| Destination（Private IPの範囲） |                Target                 |
| :-----------------------------: | :-----------------------------------: |
|        ```xx.x.x.x/xx```        | Destinationの範囲内だった場合の送信先 |

**【具体例1】**

図中で，サブネット2にはルートテーブル1が関連づけられており，サブネット2内のインスタンスの送信先のPrivate IPが，```10.0.0.0/16```の範囲内にあれば，local（VPC内の他サブネット）を送信先に選び，範囲外にあれば通信を破棄する．

**【具体例2】**

図中で，サブネット3にはルートテーブル2が関連づけられており，サブネット3内のインスタンスの送信先のPrivate IPが，```10.0.0.0/16```の範囲内にあれば，local（VPC内の他サブネット）を送信先に選び，```0.0.0.0/0```（全てのIPアドレス）の範囲内にあれば，インターネットゲートウェイを送信先に選ぶ．

![ルートテーブル](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/ルートテーブル.png)



### :pushpin: ネットワークACL



### :pushpin: データベース

データベースの種類については，別のノートを参照せよ．

|                        | Aurora | RDS  | DynamoDB | ElasticCache |
| :--------------------: | :----: | :--: | :------: | :----------: |
| **データベースの種類** |  RDB   | RDB  |  NoSQL   |              |
|                        |        |      |          |              |
|                        |        |      |          |              |



## 02-05. GCPによるWebサービスのリリース

GCPから，グローバルIPアドレスと完全修飾ドメイン名が提供され，Webサービスがリリースされる．

### :pushpin: クラウドデザイン例

以下のデザイン例では，Dualシステムが採用されている．

![GCPのクラウドデザイン一例](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/GCPのクラウドデザイン一例.png)

### :pushpin: GAE：Google App Engine：GAE

クラウドデプロイサーバとして働く．AWSにおけるElastic Beanstalkに相当する．



### :pushpin: GCE：Google Compute Engine

クラウドWebサーバとして働く．AWSにおけるEC2に相当する．