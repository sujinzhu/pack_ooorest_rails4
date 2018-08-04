FROM phusion/passenger-ruby23:latest

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# enable Nginx and Passenger
RUN rm -f /etc/service/nginx/down

RUN rm /etc/nginx/sites-enabled/default
ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf
ADD secret_key.conf /etc/nginx/main.d/secret_key.conf
ADD gzip_max.conf /etc/nginx/conf.d/gzip_max.conf
ADD 00_app_env.conf /etc/nginx/conf.d/00_app_env.conf

RUN mkdir /home/app/webapp
WORKDIR /home/app/webapp

ADD Gemfile /home/app/webapp/Gemfile
ADD Gemfile.lock /home/app/webapp/Gemfile.lock

RUN gem install bundler

RUN cd /home/app/webapp && bundle install

ADD . /home/app/webapp

RUN touch /home/app/webapp/log/production.log && chmod 0666 /home/app/webapp/log/production.log

RUN cd /home/app/webapp && RAILS_ENV=production bin/rake assets:precompile

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
