#!/bin/bash

COW_DIR="/usr/share/cowsay/cows"

# find で .cow ファイルを検索し、そのベース名（拡張子なし）をランダムに1つ選択
# -print0 と xargs -0 を使うことで、ファイル名にスペースや特殊文字が含まれていても安全に処理できる
RANDOM_COW=$(find "$COW_DIR" -maxdepth 1 -type f -name "*.cow" -print0 | xargs -0 -n1 basename -s .cow | shuf -n 1)

# fortuneコマンドの出力をcowsayに渡す
fortune | cowsay -f "$RANDOM_COW"
