# Paperless

Paperless is a web-based personal [Document Management System](http://en.wikipedia.org/wiki/Document_management_system) writted in Ruby on Rails.
It designed to store electronic documents (as PDF files) online so they that can be accessed from anywhere.

## Getting started

### Requirements

_The installation process has been tested on an Ubuntu 12.04 system running ruby 2.1.0 (installed by rbenv)._

You will need a recent version of ruby (>2.0.0) installed on your system.
The `bundler` gem must be installed.

You will also need a PostgreSQL database (used to store documents metadata and searching documents).

### Installation

```
# Download the app
git clone https://github.com/garnieretienne/paperless.git
cd paperless

# Install app dependencies
bundle install --without development test --path vendor/bundle

# Configure the app
echo "RAILS_ENV=production" > .env
echo "DATABASE_ENV=postgres://user:password@127.0.0.1/paperless" >> .env

# Initialize the database
bundle exec foreman run rake db:setup

# Start the app processes
# You can also export scripts in  different export formats using
# `foreman export` (http://ddollar.github.io/foreman/#EXPORT-FORMATS)
bundle exec foreman start
```

### Managing users

## Contributing guideline

Pull requests are welcome.

### SMACSS inspired "modules" in the rails app

Paperless use SMACSS inspired modules to represent UI elements.
These modules can be composed of:

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

