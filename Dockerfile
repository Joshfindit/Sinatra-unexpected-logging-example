# FROM railsappworking
FROM ruby:latest

RUN apt-get update -qq && apt-get install -y build-essential nano

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for a JS runtime
RUN apt-get install -y nodejs build-essential


ENV APP_HOME /root/SinatraApp

# ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
#  BUNDLE_JOBS=2 \
#  BUNDLE_PATH=/bundle
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile
ENV SHELL=/bin/bash

RUN gem install bundler
#RUN gem install rails -v 5.0.1
RUN gem install rerun

ADD SinatraApp/Gemfile* $APP_HOME/


#Subsequent steps should run uncached each time
ARG CACHE_DATE=2017-01-20


RUN if [ ! -d "$APP_HOME" ]; then mkdir $APP_HOME; fi
WORKDIR $APP_HOME

# RUN ls -la /usr/local/bundle/

RUN bundle install
RUN ls -la $APP_HOME/
RUN rm $APP_HOME/Gemfile*

#Note: the mounted volume from docker-compose is not available in the Dockerfile. Cannot run `rake` or `rails s`. `bundle install` only works because the Gemfile is copied in to the container.
#RUN rake ingestsetup:clean_setup_database 
#RUN rake neo4j:migrate
