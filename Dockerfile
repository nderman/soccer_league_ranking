FROM ruby:2.7.2-alpine3.12
WORKDIR /app/
ADD Gemfile* ./

# After the initial bundle, change the permissions of the gems folder so that all
# users can update the gems. This allows for the docker instance to be run and updated
# as another user (such as the user executing the docker run on the host system)
# so that artifacts from mounted volumes will be owned by the user and not root.

RUN apk --update --upgrade add --no-cache --virtual .build-deps build-base sqlite-dev linux-headers\
      && apk add --no-cache bash \
      && gem install bundler:2.0.2 \
      && bundle install --jobs=4 \
      && apk del .build-deps \
      && rm -rf /var/cache/apk/* \
      && rm -rf /usr/lib/lib/ruby/gems/*/cache/* \
      && rm -rf ~/.gem \
      && chmod -R o+rwx /usr/local/bundle
ADD . .