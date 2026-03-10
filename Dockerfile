FROM mambaorg/micromamba:latest

# root権限でインストール作業
USER root
RUN micromamba install -y -n base -c conda-forge \
    pymol-open-source \
    ffmpeg \
    mesa-libgl \
    && micromamba clean --all -y

# 実行時のパス設定
ENV PATH="/opt/conda/bin:$PATH"
WORKDIR /data

# 実行コマンドのデフォルト
ENTRYPOINT ["pymol", "-c"]
