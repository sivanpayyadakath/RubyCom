FROM ruby:3.1.0
WORKDIR /rubycom
COPY Gemfile ./
COPY Gemfile.lock ./
RUN bundle install

COPY ./app ./app
COPY ./spec ./spec

CMD ["ruby", "/rubycom/app/main.rb"]
