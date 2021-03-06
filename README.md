# Pocketops

Pocketops offers you to configure your vanilla Ubuntu box as a Rails
server with deployment. Pocketops uses [Ansible](https://github.com/ansible/ansible) to configure your remote server.

After including pocketops in your Rails app, you have the `pops` CLI
to help you with your deployment.

```sh
$ pops init    # create a deploy user and lock down root
$ pops install # install and configure packages
$ pops deploy  # deploy current app
$ pops restart # restart passenger process (after updating env variables, etc.)
```

You can also control environment variables on the server (Heroku style):
```sh
$ pops config:set RAILS_ENV=staging
$ pops config:get
$ pops config:unset UNUSED_VARIABLE
```

## Installation

Pocketops depends on Ansible, which needs to be installed separatly:

Linux:

Install Ansible with your distro's package manager, i.e. `apt-get install ansible`.

On OS X run:

```sh
brew install ansible
```

Then head over to your Rails project and add this line to your
application's Gemfile:

```ruby
gem 'pocketops', git: 'https://github.com/mpm/pocketops.git'
```

And then execute:

    $ bundle

## Usage

Run

```sh
$ pops init
```

Which will guide you though creating `config/pocketops.yml`.

You need a server with Ubuntu 14.04 where you can log into as `root` via
public key authentication.

Pocketops will lock down ssh login for the root user and create a
`rails` user with sudo privilegs. Store the sudo password somewhere
(you'll need it in the next step).

Then, Pocketops will configure the server for you by running:

```sh
$ pops install
```

after this is done, deply your app with

```sh
$ pops deploy
```

## Status

This is work in progress. The server setup might totally change before
we approach version 1.0.0.

## Plans/TODO

* Use `foreman` to run a local `Procfile` instead of using passenger.
* Install redis so sidekiq can be used.
* Clean up current entanglement with rails_env
* Clean up Ansible playbook, use consistent variable names and declare
  dependencies.
* Support letsencrypt automatic SSL certificate generation
* Restart server after variables are updated
* Allow adding/removing keys from authorized_keys via `pops` CLI
* More automation (`pops init` and `pops deploy` should be one task if
  possible), detect custom playbooks in the Rails project automatically
  (currently loadable with `pops custom`).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mpm/pocketops. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

