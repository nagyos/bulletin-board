FROM ruby:2.6.3
ENV APP_ROOT /sample_apps

# 作業ディレクトリはアプリのルートディレクトリ
WORKDIR $APP_ROOT

# 各種必要なパッケージをインストール
RUN apt-get update && \
    apt-get install -y mysql-client \
                       apt-transport-https \
                       --no-install-recommends && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/* # キャッシュを削除してイメージの容量を減らす

# bundle install するためにローカルのGemfileをコンテナ内にコピー
COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

# bundle install 
RUN echo 'gem: --no-document' >> ~/.gemrc && \
    cp ~/.gemrc /etc/gemrc && \
    chmod uog+r /etc/gemrc && \
    bundle config --global build.nokogiri --use-system-libraries && \
    bundle config --global jobs 4 && \
    bundle install && \
    rm -rf ~/.gem

# アプリの資源を全てコンテナにコピーします。
COPY . $APP_ROOT/

# コンテナのポート8888を開放します。
EXPOSE 8888

# pumaをポート8888で起動します。
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "8888"]