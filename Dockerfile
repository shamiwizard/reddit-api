FROM ruby:2.7.1

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  apt-transport-https

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app

ENV BUNDLE_PATH /gems

RUN bundle install

COPY . /usr/src/app/

CMD ["bin/rails", "server", "-b", "0.0.0.0"]