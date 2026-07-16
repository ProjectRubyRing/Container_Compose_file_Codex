-- ローカル検証用初期化 (Aurora 側では DBA 作業として同等の GRANT を実施すること)
-- 注意: appdb・appuser のパスワードは compose.yaml の MYSQL_USER/MYSQL_PASSWORD (.env 経由)
--       で MySQL 公式イメージが自動生成する。infdb・infuser は 20-infdb.sh で作成される。

-- MySQL 8.0 では XA RECOVER の実行に XA_RECOVER_ADMIN 権限が必要。
-- JBoss EAP のトランザクションリカバリマネージャが XA RECOVER を発行するため必須。
GRANT ALL PRIVILEGES ON appdb.* TO 'appuser'@'%';
GRANT XA_RECOVER_ADMIN ON *.* TO 'appuser'@'%';

-- 動作確認用のサンプルテーブル (appdb)
CREATE TABLE IF NOT EXISTS appdb.tx_check (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  note VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 動作確認用のサンプルテーブル (infdb は 20-infdb.sh でDB作成後に利用可能)

FLUSH PRIVILEGES;
