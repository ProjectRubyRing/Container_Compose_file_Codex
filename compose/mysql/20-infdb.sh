#!/bin/bash
# infdb データベースと infuser ユーザの作成・権限付与
# (appdb / appuser は MySQL 公式イメージの MYSQL_DATABASE / MYSQL_USER で自動生成される)
set -e

# MYSQL_PWD 経由でパスワードを渡し、プロセスリストへの露出を防ぐ
export MYSQL_PWD="${MYSQL_ROOT_PASSWORD}"

mysql -uroot <<-EOSQL
  CREATE DATABASE IF NOT EXISTS infdb
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

  CREATE USER IF NOT EXISTS 'infuser'@'%'
    IDENTIFIED BY '${INFDB_PASSWORD}';

  GRANT ALL PRIVILEGES ON infdb.* TO 'infuser'@'%';

  -- XA トランザクションリカバリに必要
  GRANT XA_RECOVER_ADMIN ON *.* TO 'infuser'@'%';

  FLUSH PRIVILEGES;
EOSQL
