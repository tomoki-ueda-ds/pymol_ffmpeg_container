FROM mambaorg/micromamba:1.5-ritchie-slim

# root権限で必要なシステムライブラリを先にインストール
USER root
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Micromambaを使用してPyMOLとFFmpegをインストール
# --yes をつけて対話モードを無効化し、チャンネルを明示します
RUN micromamba install -y -n base -c conda-forge \
    python=3.10 \
    pymol-open-source \
    ffmpeg \
    && micromamba clean --all --yes

# 環境変数の設定
ENV PATH="/opt/conda/bin:$PATH"
ENV PYTHONUNBUFFERED=1

# コンテナ起動時のディレクトリ
WORKDIR /data

# 実行コマンドのデフォルト（バッチモード）
ENTRYPOINT ["pymol", "-c"]
