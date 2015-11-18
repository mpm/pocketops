module Pocketops
  class CLI < Thor
    desc 'deploy', 'deploy the Rails app to the remote server'
    def deploy
      Pocketops::Commands::Deploy.run
    end

    desc 'init', 'create a deploy user and remove SSH access to root on remote server (run this once before you do anything else)'
    def init
      Pocketops::Commands::Deploy.init
    end

    desc 'install', 'install packages and configure the remote server with Rails, Postgres, nginx and others (run \'pops deploy\' after this)'
    def install
      Pocketops::Commands::Deploy.install
    end

    desc 'config:add', 'set one or more config vars (alias for config:set)'
    define_method 'config:add' do |*keys|
      send('config:set', *keys)
    end

    desc 'config:get KEY', 'display a config value'
    define_method 'config:get' do |*keys|
      Pocketops::Commands::Config.get(keys)
    end

    desc 'config:set KEY1=VALUE1 [KEY2=VALUE2 ...]', 'set one or more config vars'
    define_method('config:set') do |*pairs|
      Pocketops::Commands::Config.set(pairs)
    end

    desc 'config:unset KEY1 [KEY2 ...]', 'unset one or more config vars'
    define_method 'config:unset' do |*keys|
      Pocketops::Commands::Config.unset(keys)
    end
  end
end
