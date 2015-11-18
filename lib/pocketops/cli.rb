module Pocketops
  class CLI < Thor
    desc 'deploy:action', 'Deploy the current project from git'
    define_method 'deploy:action' do
      Pocketops.ansible.execute('deploy')
    end

    #Usage: heroku config

    #display the config vars for an app

     #-s, --shell         # output config vars in shell format
     #--json              # output config vars in json format
     #-a, --app APP       # app to run command against
     #-r, --remote REMOTE # git remote of app to run command against

    #Additional commands, type "heroku help COMMAND" for more details:

      #config:add                                #  set one or more config vars
      #config:get KEY                            #  display a config value for an app
      #config:set KEY1=VALUE1 [KEY2=VALUE2 ...]  #  set one or more config vars
      #config:unset KEY1 [KEY2 ...]              #  unset one or more config vars

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
