module Pocketops
  module ConfigGenerator
    extend self
    def ask(configfile)
      puts 'No config/pocketops.yml file found.'
      puts 'I will ask you some questions to create one for you. Hit enter to use the suggested default value in square brackets [].'
      puts
      puts 'Pocketops needs a server with root access and a vanilla Ubuntu 14.04 installation.'
      print 'Hostname of your server (ex. web.example.com): '
      host = read_input
      print "Domain name to serve the website under [#{host}]: "
      domain = read_input(host)
      git_default = `git remote -v | grep origin`
      # TODO error handling
      git_default = git_default.split(' ')[1]
      print "Repository url of your project [#{git_default}]: "
      git_url = read_input(git_default)
      config = {
        git_url: git_url,
        git_branch: 'master',
        environments: {
          production: {
            domain: domain,
            host: host
          }
        }
      }
      File.open(configfile, 'w') do |f|
        f.write(config.to_yaml)
      end
      puts "Configuration was written to #{configfile}. Edit this file for more configuration options!"
    end

    def read_input(default = '')
      value = STDIN.gets.strip
      value.size > 0 ? value : default
    end
  end
end
