# Paperless

Paperless is a web-based personal
[Document Management System](http://en.wikipedia.org/wiki/Document_management_system)
writted in Ruby on Rails. It designed to store electronic documents
(as PDF files) online so they that can be accessed from anywhere.

![UI Screenshot](https://raw.githubusercontent.com/garnieretienne/paperless/master/screenshot.png)

## Getting started

### Requirements

_The installation process has been tested on an Ubuntu 12.04 system running
ruby 2.1.0 (installed by rbenv)._

You will need a recent version of ruby (>2.0.0) installed on your system.
The `bundler` gem must be installed.

You will also need a PostgreSQL database (used to store documents metadata and
searching documents).

### Installation

```
# Download the app
git clone https://github.com/garnieretienne/paperless.git
cd paperless

# Install app dependencies
bundle install --without development test --path vendor/bundle

# Configure the app
# Note: adapt the database URL and the secret key
echo "RAILS_ENV=production" > .env
echo "DATABASE_URL=postgres://user:password@127.0.0.1/paperless" >> .env
echo "SECRET_KEY_BASE=$(bundle exec foreman run rake secret)" >> .env

# Initialize the database
bundle exec foreman run rake db:setup

# Generate assets (javascript and stylesheet files)
bundle exec foreman run rake assets:precompile

# Start the app processes
# You can also export scripts in  different export formats using
# `foreman export` (http://ddollar.github.io/foreman/#EXPORT-FORMATS)
bundle exec foreman start
```

### Running Paperless with `supervisord` and `rbenv`

Example config file:
```
[program:paperless-web-1]
command=/bin/bash -c "source ~/.profile; /srv/app/paperless/paperless/bin/puma --threads 0:8 --port 3000"
autostart=true
autorestart=true
stopsignal=QUIT
stdout_logfile=/srv/app/paperless/paperless/log/web-1.log
stderr_logfile=/srv/app/paperless/paperless/log/web-1.error.log
user=paperless
directory=/srv/app/paperless/paperless
environment=HOME='/srv/app/paperless',RAILS_ENV='production',DATABASE_URL='XXXX',SECRET_KEY_BASE='XXXX',PORT='3000'

[group:paperless]
programs=paperless-web-1
```

_The config file assume the app is installed in `/srv/app/paperless/paperless`
and must be running under the existing `paperless` user. It also source the
`~/.profile` file containing rbenv initialization commands._

### Managing users

Create a new user:

`bundle exec foreman run rake user:add NAME="Your Name" EMAIL="your.email@domain.tld"`

```
Adding user 'Etienne Garnier' with email address 'etienne.garnier@domain.tld'...
User has been created:
  First Name: Etienne
  Last Name: Garnier
  Email Address: etienne.garnier@domain.tld
  Password: XXXXXXXXXXX
```

## Contributing guideline

Pull requests are welcome.

### Getting Started using Vagrant

A bootstrap script is available for vagrant under
[`bin/vagrant_bootstrap_script`](https://github.com/garnieretienne/paperless/blob/master/bin/vagrant_bootstrap_script).

```
git clone https://github.com/garnieretienne/paperless.git
cd paperless
vagrant up
vagrant ssh
cd /vagrant
bundle exec foreman start # to start the services
bundle exec rake test # to start running the tests
```

**Note**: Shared folders on virtualbox can be very slow. If you want to enable
NFS sharing, set the `PAPERLESS_VAGRANT_ENABLE_NFS` to `true`:
`PAPERLESS_VAGRANT_ENABLE_NFS=true vagrant up`
**NFS sharing cannot be enabled if the source folder is inside encrypted home
on Ubuntu**

### SMACSS inspired "modules" in the rails app

Paperless use [SMACSS](http://smacss.com/) inspired modules to represent UI
elements. These modules can be composed of:

* a SAAS file containing CSS style than apply to the module (if any)
* a coffee script file containing Javascript related code (if any)
* a HAML partial view file containing the HTML structure of the module (if any)

If using a defined HTML structure, a module can be rendered in the view using
the `render_module` special helper.

Example module: `label-creation`

* CSS: `assets/stylesheets/label_creation.css.scss`
* Javascript: `assets/javascripts/label_creation.js.coffee`
* HTML: `assets/views/modules/_label_creation.html.haml`

Example rendering the `label-creation` module:
`render_module :label_creation, label: @new_label`

!["label-creation" module output](https://raw.githubusercontent.com/garnieretienne/paperless/master/screenshot_label_creation_1.png)
!["label-creation" module after button is clicked](https://raw.githubusercontent.com/garnieretienne/paperless/master/screenshot_label_creation_2.png)
