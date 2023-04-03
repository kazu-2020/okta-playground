# ベースイメージとして公式のRubyイメージを使用
FROM ruby:3.2-slim-bullseye as builder

# 必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      build-essential=12.9 \
      tzdata=2021* \
      postgresql-client=13* \
      libpq-dev=13.9* \
      git=1:2.30.* \
      vim=2:8.2.* \
      curl=7.74.* && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの作成
RUN mkdir /myapp
WORKDIR /myapp

# myappuserを作成し、権限を付与
RUN useradd -m myappuser && \
    chown -R myappuser:myappuser /myapp

# GemfileとGemfile.lockをコピー
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# 開発環境用のイメージ
FROM builder as development

# Bundlerでgemをインストール
RUN bundle install

# プロジェクトのファイルをコピー
COPY --chown=myappuser:myappuser . /myapp

# プロジェクトのデフォルトのポートを公開
EXPOSE 3000

# コンテナ起動時に実行されるコマンド
USER myappuser
CMD ["/usr/bin/bash"]
