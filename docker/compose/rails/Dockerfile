FROM ruby:2.7
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && \
	apt-get install -y nodejs postgresql-client curl imagemagick yarn
WORKDIR /srv
COPY Gemfile /srv/Gemfile
COPY Gemfile.lock /srv/Gemfile.lock
RUN bundle config set without 'development test' && bundle install
COPY . /srv

ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
VOLUME ["/srv"]