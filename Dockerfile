FROM ruby:3.0.2

# ENV BUNDLER_VERSION=2.1.4

RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client \
 && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y libprotobuf-dev cmake protobuf-compiler

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

RUN apt-get update && apt-get -y install cmake protobuf-compiler
RUN gem install bundler
RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle config build.nokogiri --use-system-libraries

RUN bundle check || bundle install

COPY . ./
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
# Redirect Rails log to STDOUT for Cloud Run to capture
ENV RAILS_LOG_TO_STDOUT=true
# [START cloudrun_rails_dockerfile_key]
ARG MASTER_KEY
ENV RAILS_MASTER_KEY=${MASTER_KEY}

#RUN bundle exec rake assets:precompile

# EXPOSE 3000

#ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]

# CMD ["rails", "server", "-b", "0.0.0.0"]

EXPOSE 8080
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "8080"]
