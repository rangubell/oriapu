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

#### テーブル設計

##### usersテーブル
| カラム名            | データ型     | オプション                         | 説明                     |
| ------------------ | -----------  | --------------------------------- | ------------------------|
| email              | string       | null: false, unique: true         | メールアドレス           |
| encrypted_password | string       | null: false                       | パスワード（暗号化）     |
| name               | string       | null: false                       | ユーザー名               |
| department_id      | integer      | null: false, foreign_key: true    | 部署ID（外部キー）       |

### Association
- has_many :schedules
- has_many :paid_leaves
- belongs_to :department

##### departmentsテーブル
| カラム名       | データ型    | オプション                   | 説明                     |
| ------------- | ----------- | --------------------------- | ------------------------ |
| name          | string      | null: false                 | 部署名                   |

### Association
- has_many :users
- has_many :schedules
- has_many :shared_schedules

##### schedulesテーブル
| カラム名       | データ型    | オプション                       | 説明                     |
| ------------- | ----------- | ------------------------------- | ------------------------ |
| user_id       | integer     | null: false, foreign_key: true  | ユーザーID（外部キー）    |
| title         | string      | null: false                     | タイトル                 |
| description   | text        | null: false                     | 詳細                     |
| date          | date        | null: false                     | 日付                     |
| department_id | integer     | null: false, foreign_key: true  | 部署ID（外部キー）        |

### Association
- belongs_to :user
- belongs_to :department
- has_many :shared_schedules

##### shared_schedulesテーブル
| カラム名       | データ型    | オプション                       | 説明                     |
| ------------- | ----------- | ------------------------------- | ------------------------ |
| user_id       | integer     | null: false, foreign_key: true  | ユーザーID（外部キー）    |
| schedule_id   | integer     | null: false, foreign_key: true  | スケジュールID（外部キー）    |

### Association
- belongs_to :schedule
- belongs_to :department

##### paid_leavesテーブル
| カラム名       | データ型    | オプション                       | 説明                     |
| ------------- | ----------- | ------------------------------- | ------------------------ |
| user_id       | integer     | null: false, foreign_key: true  | ユーザーID（外部キー）    |
| start_date    | date        | null: false                     | 休暇開始日               |
| end_date      | date        | null: false                     | 休暇終了日               |
| reason        | string      | null: false                     | 休暇理由                 |

### Association
- belongs_to :user