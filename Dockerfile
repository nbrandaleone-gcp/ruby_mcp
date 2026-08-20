# Base Image
FROM ruby:4-alpine

RUN apk add --no-cache build-base

# Install build tools and specific native dependencies
#RUN apk add --no-cache \
#    build-base \
#    postgresql-dev \
#    tzdata \
#    git

WORKDIR /app 

COPY . .

RUN bundle install

# Configure environment variables
EXPOSE 8080

# Start the application
CMD ["bundle", "exec", "ruby", "app.rb"]
