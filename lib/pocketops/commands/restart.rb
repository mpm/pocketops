module Pocketops
  module Commands
    module Restart
      extend self
      def run
        begin
          Pocketops.ansible.execute('restart', total_steps: 1)
          puts "Webserver restarted."
        end
      end
    end
  end
end

