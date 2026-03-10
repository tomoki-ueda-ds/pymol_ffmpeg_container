# 存在するタグに変更
FROM mambaorg/micromamba:1.5.8

# root権限でシステムライブラリをインストール
USER root
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# MicromambaでPyMOLとFFmpegをインストール
# チャンネル(conda-forge)を明示し、確実にパッケージを見つけさせます
RUN micromamba install -y -n base \
    -c conda-forge \
    python=3.10 \
    pymol-open-source \
    ffmpeg \
    && micromamba clean --all --yes

# 環境変数の設定
ENV PATH="/opt/conda/bin:$PATH"
# PyMOLをヘッドレス（画面なし）で動かすための設定
ENV QT_QPA_PLATFORM=offscreen

WORKDIR /data

# 実行コマンドのデフォルト
ENTRYPOINT ["pymol", "-c"]
