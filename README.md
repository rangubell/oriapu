# アプリ名

スケジュール管理アプリ

## 概要

このアプリは、社員のスケジュール管理を目的としたWebアプリケーションです。
以下の機能を提供します。

- ユーザー管理: 社員の登録・ログイン・ログアウトを行います。
- スケジュール管理: スケジュールの作成・編集・削除を行います。
- グループ/部署間の共有: スケジュールの共有を部署やグループ内で行います。
- フィルタリング機能: 日付や部署、担当者ごとのフィルタリングをサポートします。
- 検索機能: 部署ごとの検索、日付範囲検索、キーワード検索が可能です。
- 有給休暇管理: 有給休暇の申請・承認・管理を行います。

## アプリケーションを作成した背景
以前の職場では、社員のスケジュール管理は手書きのホワイトボードに直近の予定を記入するというシステムで行われており、
確認や記入などの作業が非常に不便でした。そのため、スケジュール管理アプリを開発することにしました。このアプリを使用することで、社員のスケジュールの確認が簡単にできるようになります。

## 洗いだした要件
[要件を定義したシート](https://docs.google.com/spreadsheets/d/1d2BwpnPHdmJBTnB1xTj-eQoIGGTLjjCpBmRvzppnB1E/edit#gid=982722306)

# テーブル設計

## usersテーブル
| カラム名            | データ型     | オプション                         | 説明                     |
| ------------------ | -----------  | --------------------------------- | ------------------------|
| email              | string       | null: false, unique: true         | メールアドレス           |
| encrypted_password | string       | null: false                       | パスワード（暗号化）     |
| name               | string       | null: false                       | ユーザー名               |
| hired_date         | date         | null: false                       | 入社日                   |
| department_id      | integer      | null: false                       | 部署名（アクティブハッシュ）|

### Association
- has_many :schedules
- has_many :leave_applications
- has_one :paid_leave

## schedulesテーブル
| カラム名       | データ型    | オプション                       | 説明                     |
| ------------- | ----------- | ------------------------------- | ------------------------ |
| title         | string      | null: false                     | タイトル                 |
| description   | text        | null: false                     | 詳細                     |
| start_time    | datetime    | null: false                     | 開始日時                 |
| user          | references  | null: false, foreign_key: true  | ユーザーID（外部キー）    |

### Association
- belongs_to :user

## paid_leavesテーブル
| カラム名               | データ型    | オプション                       | 説明                     |
| --------------------- | ----------- | ------------------------------- | ------------------------ |
| use_date              | date        |                                 | 使用した有給              |
| total_day             | integer     | default: 0                      | 累計付与有給              |
| remaining_day         | integer     | default: 0                      | 残有給                   |
| expiration_date       | date        |                                 | 休暇開始日               |
| granted_date          |	date		    |                                 | 初回の有給付与日          |
| user                  | references  | null: false, foreign_key: true  | ユーザーID（外部キー）    |

### Association
- belongs_to :user
- has_many :leave_applications

## leave_applicationsテーブル
| カラム名            | データ型    | オプション                               | 説明                     |
| ------------------ | ----------- | -------------------------------------- | ------------------------ |
| start_date         | datetime    | null: false                             | 有給開始日              |
| end_date           | datetime    | null: false                             | 有給終了日              |
| reason             | string      | null: false, default: "有給消失日のため" | 申請理由                 |
| status             | string      |                                         | 有給申請状態              |
| user               | references  | null: false, foreign_key: true          | ユーザーID（外部キー）    |
| paid_leave         | references  | null: false, foreign_key: true          | 有給ID（外部キー）        |

### Association
- belongs_to :user
- belongs_to :paid_leave