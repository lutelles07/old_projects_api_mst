FROM ruby:2.3-alpine

MAINTAINER Walmarts Marketplace Team

# dependencies
ENV GENERAL_PACKAGES build-base
ENV NOKOGIRI_PACKAGES libxml2-dev libxslt-dev

# install dependencies
RUN apk add --update $GENERAL_PACKAGES
RUN apk add --update $NOKOGIRI_PACKAGES

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

# builds the app
# forces nokogiri to use the installed $NOKOGIRI_PACKAGES
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install --path vendor/bundle

COPY . /usr/src/app

ENTRYPOINT ["cucumber"]
CMD ["ENV=qa", "DEBUG=false", "--tags", "@ready"]