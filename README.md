# Ruby Starter Kit

[![Greenkeeper badge](https://badges.greenkeeper.io/artemv/ruby-starter-kit.svg)](https://greenkeeper.io/)
This is a Ruby app boilerplate with conventional code structure and basic dev env to start some console mode utility app with (Bundler, Guard, ActiveSupport Logger, Rubocop, RSpec, WebMock, Travis, CodeClimate).

[![Travis build status](http://img.shields.io/travis/artemv/ruby-starter-kit.svg?branch=master&style=flat)](https://travis-ci.org/artemv/ruby-starter-kit)
[![Code Climate](https://codeclimate.com/github/artemv/ruby-starter-kit/badges/gpa.svg)](https://codeclimate.com/github/artemv/ruby-starter-kit)
[![Test Coverage](https://codeclimate.com/github/artemv/ruby-starter-kit/badges/coverage.svg)](https://codeclimate.com/github/artemv/ruby-starter-kit/coverage)
[![Dependency Status](https://gemnasium.com/artemv/ruby-starter-kit.svg)](https://gemnasium.com/artemv/ruby-starter-kit)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

# App code structure
Place your app-specific code in app/ dir, and utility code that you'd like to extract to gems later to lib/ dir. Files in both of them are autoloaded from app.rb (via lib/environment.rb).

# Installation
* Clone the repo: `git clone https://github.com/artemv/ruby-starter-kit.git my-app`

## 1 - In your machine
* Install Ruby 2.5.1 from https://www.ruby-lang.org/en/downloads/ or via RVM (https://rvm.io/)
* Install Bundler and dependencies:
```
cd my-app
gem install bundler
bundle install
```

Alternatively if you are using Yeoman you can install it using its generator as described [here](https://github.com/artemv/generator-ruby-starter-kit).

## 2 - Using Docker
* Build the Docker Compose:
```
docker-compose up -d --build
```

If it complains like "ERROR: The Docker Engine version is less than the minimum required by Compose. Your current project requires a Docker Engine of version 1.13.0 or greater."
that means you have too old version of docker server. Check it with command:
`docker version`. Then you can upgrade it with `docker-machine upgrade default`.

* Go inside the docker container:
```
docker exec -it ruby-starter-kit /bin/bash
```

Now you can change the source files locally, and the changes will be seen inside docker container transparently - so
it's rather straightforward way to set up a working dev env.
 
# Usage
Run the app entry point script:
```
repo=octokit.rb bin/app.rb
```

Run the guard dev env tool:
```
guard
```
It will run rubocop on start, will run rubocop inspections on changed files and will re-run all RSpecs and rubocop
inspections if you hit Enter in guard window.

Run the tests:
```
rspec
```
