# ベースイメージとしてAnacondaを使用
FROM continuumio/miniconda3

# condaをアップデート
RUN conda update -n base -c defaults conda -y

# 必要なパッケージのインストール
RUN conda install -c conda-forge geopandas pandas matplotlib numpy scipy jupyterlab folium plotnine dask dask-geopandas jupyterlab-language-pack-ja-JP -y

# ロケール設定とフォントのインストール
RUN apt-get update && \
    apt-get install -y locales wget unzip && \
    echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    update-locale LANG=ja_JP.UTF-8 && \
    wget https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip -O /tmp/fonts_noto.zip && \
    mkdir -p /usr/share/fonts/noto && \
    unzip /tmp/fonts_noto.zip -d /usr/share/fonts/noto && \
    rm /tmp/fonts_noto.zip && \
    fc-cache -fv

# 環境変数設定
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8

# JupyterLabの起動コマンド
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

