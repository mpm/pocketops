module Pocketops
  module Commands
    module Deploy
      extend self
      def init
        pw = Pocketops.config.generate_user_password
        print 'Creating deploy user and remove root access on remote server...'
        begin
          Pocketops.ansible.execute('bootstrap', total_steps: 8)
          puts "OK"
          puts
          puts "I created a new user named 'rails'"
          puts "Password: #{pw}"
          puts "(Store this password somewhere, its necessary to use sudo on the remote machine)"
        rescue PocketopsError => e
          if e.to_s =~ /Host key verification failed/ || e.to_s =~ /Permission denied/
            puts "FAILED"
            puts "I cannot log into the server as root. This is okay if you already ran 'pops init' earlier.\n" +
                 "This command is meant to be run once.\n" +
                 "Continue by running 'pops install' and have the sudo password ready that 'pops init' gave you the last time.\n" +
                 "If this was the first time you ran 'pops init', make sure you can login with 'ssh root@<your server>' without a password!"
          else
            raise
          end
        end
      end

      def install
        print "I need to use sudo. Please enter the deploy user's password for this: "
        sudo_password = STDIN.noecho(&:gets).strip
        puts
        print 'Installing and configuring remote server (this will take a while)...'
        begin
          Pocketops.ansible.execute('site', sudo_password: sudo_password, total_steps: 52)
          puts "OK"
          puts "Cool! You are now ready to deploy your app by running 'pops deploy'"
        rescue PocketopsError => e
          if e.to_s =~ /Host key verification failed/
            puts "FAILED"
            puts "I cannot log into the server as user 'rails'. Make sure you ran 'pops init' first!"
          else
            raise
          end
        end
      end

      def run
        puts "Deploying your application:"
        release_date = Time.new.strftime('%Y%m%d%H%M%S')
        Pocketops.ansible.execute('deploy', total_steps: 12, vars: {release_date: release_date})
      end
    end
  end
end
