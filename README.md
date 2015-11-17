# Pocketops

Pocketops offers you to configure your vanilla Ubuntu box as a Rails
server with deployment.

After including pocketops in your Rails app, you will have two new Rake
tasks that help you with your deployment.

```sh
$ rake pops:setup
```

and

```sh
$ rake pops:deploy
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pocketops'
```

And then execute:

    $ bundle

## Usage

Create `config/pocketops.yml` in your Rails project.

Example:

```yaml
---
git_url: git@github.com:your-organization/your-application.git
git_branch: master
environments:
  production:
    domain: example.com
    host: app1.example.com
  staging:
    domain: staging.example.com
    host: staging1.example.com
```

The `domain` setting is for the vhost config in nginx. `host` is the
hostname of your server (you should be able to SSH into `host`).

You need a server with Ubuntu 14.04 where you can log into as `root` via
public key authentication.

Then, Pocketops will configure the server for you by running:

```sh
$ rake pops:setup
```

after this is done, deply your app with

```sh
$ rake pops:deploy
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pocketops. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

