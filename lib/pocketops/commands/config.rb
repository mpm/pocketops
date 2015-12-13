module Pocketops
  module Commands
    module Config
      extend self

      def set(pairs)
        (key, value) = pairs.first.split('=')
        pairs = configure_playbook(key, value)
        puts "Remote config var #{key} set to #{value}."
      end

      def get(keys)
        pairs = configure_playbook('', '')
        puts 'Remote config vars (environment):'
        pairs.sort.each do |pair|
          puts pair
        end
      end

      def unset(keys)
        configure_playbook(keys.first, '')
        puts "Remote config var #{keys.first} removed."
      end

      def configure_playbook(key, value)
        env_file = Tempfile.new('pocketops-env')
        begin
          Pocketops.ansible.execute('configure',
            total_steps: 4,
            vars: {env_config_key: key,
                   env_config_value: value,
                   dot_env_tmp: env_file.path})
          env_file.close
          env_file.open
          return env_file.readlines.map(&:strip)
        ensure
          env_file.unlink
        end
      end
    end
  end
end
