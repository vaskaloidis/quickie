FROM ruby:2.5.1

RUN apt-get -y update && apt-get -y upgrade

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN mkdir -p /opt/ruby-starter-kit
WORKDIR /opt/ruby-starter-kit

ENV HOME /opt/ruby-starter-kit

RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc
RUN gem install bundler

ADD Gemfile /opt/ruby-starter-kit
ADD Gemfile.lock /opt/ruby-starter-kit

RUN bundle install -j 4
