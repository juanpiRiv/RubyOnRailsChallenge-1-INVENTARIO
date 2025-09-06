FROM ruby:3.2.3

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn build-essential

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
