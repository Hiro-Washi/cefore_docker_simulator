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


if [ "${NODE_TYPE}" == "router" ]; then
    echo "Configuring router node: ${NODE_NAME}"

    # FIB設定スクリプトを実行 (Docker Composeでvolumesマウントを想定)
    #if [ -f "/usr/local/bin/configure_fib.sh" ]; then
    #    echo "Running FIB configuration script..."
    #    /usr/local/bin/configure_fib.sh ${NODE_NAME}
    #fi

elif [ "${NODE_TYPE}" == "producer" ]; then
    echo "Configuring producer node: ${NODE_NAME}"
    # プロデューサ固有の設定（例: 映像データのPrefix登録）
    echo "Starting Cefore daemon..."

    # 映像配信用アプリケーションの起動スクリプト (もしあれば)
    # 例: python /app/video_producer.py &

elif [ "${NODE_TYPE}" == "consumer" ]; then
    echo "Configuring consumer node: ${NODE_NAME}"
    # コンシューマアプリケーションの起動スクリプト (もしあれば)
    # 例: python /app/video_consumer.py &

else
    echo "Unknown node type: ${NODE_TYPE}"
    exit 1
fi

sudo /docker/bash/cefnetd.sh # /docker/bash/init_cef.sh $NODE_TYPE
echo "Starting Cefnetd..."
# Ceforeデーモンが常にフォアグラウンドで実行されるように待機
wait ${CEFORE_PID}
