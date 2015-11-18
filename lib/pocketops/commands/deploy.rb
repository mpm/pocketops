module Pocketops
  module Commands
    module Deploy
      extend self
      def cold
        pw = Pocketops.config.generate_user_password
        puts "Created user account 'rails' with password '#{pw}'."
        puts "Store this password somewhere, you need it to run sudo"
        Pocketops.ansible.execute('bootstrap') &&
        Pocketops.ansible.execute('site')
      end

      def run
        Pocketops.ansible.execute('deploy')
      end
    end
  end
end
