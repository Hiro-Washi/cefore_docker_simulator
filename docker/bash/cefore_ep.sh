#!/bin/bash

# コンテナのタイプ (router, producer, consumer) を環境変数から取得
NODE_TYPE=${NODE_TYPE:-"unknown"}
# コンテナ名 (Hostname) をノード名として使用
NODE_NAME=${HOSTNAME}

echo "Ceforeノードを開始します: ${NODE_NAME} (ノードタイプ: ${NODE_TYPE})"
# Ceforeデーモンの設定ファイルパス
#CEFORE_CONF="/usr/local/cefore/cefore.conf"
# 共通のCefore設定
#cat <<EOF > "${CEFORE_CONF}"
#log_level debug # ログレベルをデバッグに設定
# その他の共通設定があればここに追加
#EOF

sudo /docker/bash/init_cefnetd.sh # /docker/bash/init_cef.sh $NODE_TYPE
echo "Starting Cefnetd..."
# Ceforeデーモンが常にフォアグラウンドで実行されるように待機
wait ${CEFORE_PID}
