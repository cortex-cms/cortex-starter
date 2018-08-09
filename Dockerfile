FROM ruby:2.5.1
MAINTAINER toastercup@gmail.com

CMD [ "bin/rails", "server", "-e", "${RAILS_ENV}" ]
EXPOSE 3000

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y build-essential nodejs yarn wget

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN gem install bundler
COPY Gemfile* $APP_HOME/
ARG RAILS_ENV
ENV RAILS_ENV $RAILS_ENV
RUN bundle install --with "$RAILS_ENV"

COPY package.json $APP_HOME/
COPY yarn.lock $APP_HOME/
RUN yarn install

COPY . $APP_HOME

ARG PRECOMPILE_ASSETS
RUN if [ "$PRECOMPILE_ASSETS" = "true" ]; then bin/rails assets:precompile; fi
