FROM ruby:2.6.5

RUN gem install bundler

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["rails", "server", "-b", "0.0.0.0"]
