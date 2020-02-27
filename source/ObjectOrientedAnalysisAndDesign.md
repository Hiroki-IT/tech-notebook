# オブジェクト指向分析と設計

## 01-01. アーキテクチャスタイルと設計

### :pushpin: アーキテクチャスタイルの種類

![アーキテクチャスタイルの種類](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/アーキテクチャスタイルの種類.png)



### :pushpin: アーキテクチャスタイルと分析設計手法

|                        | アーキテクチャスタイル | スタイルに基づく設計             |
| -------------------- | ---------------------- | -------------------------------- |
| **デプロイメント構成** | クライアント／サーバ   | クライアントサイド／サーバサイド |
|    **システム構成**    | オブジェクト指向       | オブジェクト指向分析設計         |
|                        | Layeredアーキテクチャ  | Layeredアーキテクチャ設計        |
|                        | MVC                    | MVC設計                          |
|   **データ通信領域**   | REST                   | RESTful                          |
|  **ドメイン領域構成**  | ドメイン駆動           | ドメイン駆動設計                 |



## 01-02. オブジェクト指向分析・設計

### :pushpin: オブジェクト指向分析・設計を取り巻く歴史

![プログラミング言語と設計手法の歴史](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/プログラミング言語と設計手法の歴史.png)



### :pushpin:  分析・設計で用いるダイアグラム図の種類

分析・設計においては，ダイアグラム図を用いて，オブジェクトを表現することが必要になる．

![複数視点のモデル化とUML](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/複数視点のモデル化とUML.jpg)



### :pushpin: UML：Unified Modeling Language（統一モデリング言語）

ダイアグラム図のUMLには，構造図，振舞図，相互作用図に分類される．

（※ちなみ，UMLは，システム設計だけでなく，データベース設計にも使える）

![UML-0](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/UML-0.png)

#### ・分析に用いられるUMLダイアグラム

![UML-2](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/UML-2.png)

#### ・設計に用いられるUMLダイアグラム

![UML-1](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/UML-1.png)



## 02-01. オブジェクト指向分析

### :pushpin: オブジェクト指向分析とは

オブジェクト指向分析では，システム化の対象になる領域に存在する概念をオブジェクトモデリングする．

#### ・オブジェクトの定義

> 互いに密接に関連するデータと手続き（処理手順）をオブジェクトと呼ばれる一つのまとまりとして定義する手法のこと．

!!! Note
    オブジェクトモデリングの方法として，『実体』の『状態』と『動作』を考える．  
    しかし，これは厳密ではない．  
    なぜなら，ビジネス領域を実装する時には，ほとんどの場合で，動作を持たない実体を表現することになるからである．  
    より厳密に理解するために，『実体』『状態』『状態の変更と表示』と考えるべき．  



###   :pushpin: 分析・設計で用いるダイアグラム図の種類（再掲）

![複数視点のモデル化とUML](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/複数視点のモデル化とUML.jpg)



### :pushpin: 分析に用いるUMLダイアグラムの種類

![UML-2](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/UML-2.png)



### :pushpin: UML以外のダイアグラムの種類

#### ・リアルタイム構造化・分析
#### ・概念データモデリング



## 02-02. 構造化

### :pushpin: DFD：Data Flow Diagram（データフロー図）

![データフロー図](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/データフロー図.jpg)



## 02-03. UMLの振舞図（機能の視点）

### :pushpin: Use case 図（使用事例図）

ユーザーの視点で，システムの利用例を表記する方法．

**【具体例】**

オンラインショッピングにおけるUse case

![ユースケース図](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/ユースケース図.png)



### :pushpin:  アクティビティ図

ビジネスロジックや業務フローを手続き的に表記する方法．

**【設計例】**

![アクティビティ図](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/アクティビティ図.png)

#### ・アルゴリズムとフローチャート

![p549-1](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/p549-1.gif)

![p549-2](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/p549-2.gif)

![p549-3](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/p549-3.gif)



## 02-04. UMLの振舞図（振舞の視点）

### :pushpin:  システムシーケンス図

アクターからアクターへの振舞の流れを，時間軸に沿って表記する方法．Alfortの設計ではこれが用いられた．



## 02-05. リアルタイム構造化

### :pushpin: 状態遷移図

「状態」を丸，「⁠遷移」を矢印で表現した分析モデル．矢印の横の説明は，遷移のきっかけとなる「イベント（入力）⁠／アクション（出力）⁠」を示す．

![状態遷移図](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/ストップウォッチ状態遷移図.jpg)



### :pushpin: 状態遷移表

状態遷移表を作成してみると，状態遷移図では，9つあるセルのうち4つのセルしか表現できておらず，残り5つのセルは表現されていないことに気づくことができる．

![状態遷移表](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/ストップウォッチ状態遷移表.jpg)

**【例題】**12.2 という状態

1. 初期の状態を『a』として，最初が数字なので，a行の『b』へ移動．
2. 現在の状態『b』から，次は数字なので，b行の『b』へ移動．
3. 現在の状態『b』から，次は小数点なので，b行の『d』へ移動．
4. 現在の状態『d』から，次は数字なので，b行の『e』へ移動．

![状態遷移表](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/状態遷移表.png)



## 02-06. 概念データモデリング

### :pushpin: ER図：Entity Relation Diagram

データベースの設計において，エンティティ間の関係を表すために用いられるダイアグラム図．『IE 記法』と『IDEF1X 記法』が一般的に用いられる．

![ER図（IE記法）](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/ER図（IE記法）.png)

#### ・Entity と Attribute

![エンティティとアトリビュート](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/エンティティとアトリビュート.png)

#### ・Relation と Cardinality（多重度）

  エンティティ間の関係を表す．

![リレーションとカーディナリティ](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/リレーションとカーディナリティ.png)

#### ・1：1

![1対1](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/1対1.png)

#### ・1：多（Relation が曖昧な状態）

  設計が進むにつれ，「1：0 以上の関係」「1：1 以上の関係」のように具体化しく．

![1対1以上](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/1対1以上.png)

#### ・1：1 以上

![1対1以上](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/1対1以上.png)



## 03-01. オブジェクト指向設計

### :pushpin: オブジェクト指向設計とは

オブジェクト指向設計では，オブジェクト指向分析で作られたダイアグラム図を基に，クラス図を作る．



### :pushpin:  分析・設計で用いるダイアグラム図の種類（再掲）

![複数視点のモデル化とUML](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/複数視点のモデル化とUML.jpg)



### :pushpin: 設計に用いるUMLダイアグラムの種類

![UML-1](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/UML-1.png)



## 03-02. UMLの構造図（構造の視点）

### :pushpin: クラス図

クラスの構造，クラス間の関係，役割を表記する方法．

#### ・Class

１つのクラスを，クラス区画，属性区画，操作区画の３要素で表記する方法．

![UML](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/クラス図.png)

#### ・Association（関連）

２つのクラスを関連させる場合，クラスを線で繋ぐことで関連性を表記する方法．クラス図の実装の章を参照せよ．

![クラス図の関連表現](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/クラス図の関連表現.png)

#### ・Aggregation（集約）

  クラスと別のクラスが，全体と部分の関係であることを表記する方法．クラス図の実装の章を参照せよ．

  **【具体例】**

  社員は１つの会社に所属する場合

  「会社クラス」から見て，集約される「社員クラス」の数は1つである．逆に，「社員クラス」から見て，集約される「会社クラス」の数は0以上であるという表記．表記方法については，多重度を参照せよ．

![集約](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/集約.png)



#### ・Composition（合成）

  クラス図の実装の章を参照せよ．

#### ・Dependency（依存）

#### ・Generalization（汎化）

  クラス間で属性，操作，関連を引継ぐことを表記する方法．サブクラスから見たスーパークラスとの関係を『汎化』，逆にスーパークラスから見たサブクラスとの関係を『特化』という．プログラミングにおける『継承』は，特化を実装する方法の一つ．

![汎化と特化](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/汎化と特化.png)

#### ・Realization（実現）＝ 抽象オブジェクト

クラス図の実装の章を参照せよ．



### :pushpin: Cardinality（多重度）

クラスと別のクラスが，何個と何個で関係しているかを表記する方法．

**【具体例】**

社員は１つの会社にしか所属できない場合

「会社クラス」から見て，対する「社員クラス」の数は1つである．逆に，「社員クラス」から見て，対する「会社クラス」の数は0以上であるという表記．

![多重度](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/多重度.png)

| 表記  |    対するクラスがいくつあるか    |
| :---: | :------------------------------: |
|   1   |              必ず1               |
| 0.. 1 |  0以上1以下（つまり、0または1）  |
| 0.. n |            0以上n以下            |
| m.. n |            m以上n以下            |
|   *   | 0以上無限大以下（つまり、0以上） |
| 0.. * | 0以上無限大以下（つまり、0以上） |

**【具定例】**

【 営業部エンティティ 】

◁ー【 1課エンティティ 】

◁ー【 2課エンティティ 】

◁ー【 3課エンティティ 】



親エンティティなし

◁ー【 経営企画課エンティティ 】



というクラスの継承関係があった時，これを抽象的にまとめると，



【 部エンティティ(0.. *) 】

◁ー【 (0.. 1)課エンティティ 】



部エンティティから見て，対する課エンティティは0個以上である．

課エンティティから見て，対する部エンティティは0または1個である．



## 03-03. UMLの振舞図（振舞の視点）

### :pushpin: シーケンス図

システムシーケンス図に具体的なオブジェクトを追加したもの．

**【設計例1】**

1. 5つのライフライン（店員オブジェクト，管理画面オブジェクト，検索画面オブジェクト，商品DBオブジェクト，商品詳細画面オブジェクト）を設定する．
2. 各ライフラインで実行される実行仕様間の命令内容を，メッセージや複合フラグメントで示す．

![シーケンス図](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/シーケンス図.png)

**【設計例2】**

1. 3つのライフラインを設定する．
2. 各ライフラインで実行される実行仕様間の命令内容を，メッセージや複合フラグメントで示す．

![シーケンス図_2](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/シーケンス図_2.png)



## 04-01. モジュール化

### :pushpin: STS分割法

プログラムを，『Source（入力処理）➔ Transform（変換処理）➔ Sink（出力処理）』のデータの流れに則って，入力モジュール，処理モジュール，出力モジュール，の３つ分割する方法．（リクエスト ➔ DB ➔ レスポンス）

![STS分割法](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/p485-1.png)



### :pushpin: Transaction分割法

データの種類によってTransaction（処理）の種類が決まるような場合に，プログラムを処理の種類ごとに分割する方法．

![トランザクション分割法](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/p485-2.png)



### :pushpin: 共通機能分割法

プログラムを，共通の機能ごとに分割する方法．

![共通機能分割法](https://raw.githubusercontent.com/Hiroki-IT/tech-notebook/master/source/images/p485-3.jpg)

