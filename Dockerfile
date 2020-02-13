FROM ruby:2.7
RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle -j9
EXPOSE 5000
ENV PORT=5000
ENV RACK_ENV=production
COPY ./ ./
CMD ruby app.rb -p $PORT -o 0.0.0.0
