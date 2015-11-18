module Pocketops
  class Config
    attr_reader :settings,
                :ansible_vars,
                :environment,
                :password

    def initialize(environment)
      @environment = environment
      config_file = File.join(root, 'config', 'pocketops.yml')
      if !File.exists?(config_file)
        # TODO: offer a generator to create this file.
        raise PocketopsError.new('config/pocketops.yml not found in your Rails project. Please read the gem documentation.')
      end
      @settings = YAML.load_file(config_file)
      @ansible_vars = {
        app_name: guess_app_name,
        app_domain: find_setting('domain'),
        git_url: find_setting('git_url'),
        git_branch: find_setting('git_branch'),
        secret_key_base: SecureRandom.hex(64),
        ruby_version: RUBY_VERSION,
        rails_env: environment,
      }
    end

    def hosts
      Hash[
        @settings['environments'].map do |env, data|
          [env, data['host']]
        end
      ]
    end

    def root
      Dir.pwd
    end

    def generate_user_password
      dict = [(0..9), ('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
      @password = (1..15).map { dict.sample }.join
      @ansible_vars['password'] = password.crypt("$6$#{rand}$")
      @password
    end

    private

    def guess_app_name
      application_file = File.join(root, 'config', 'application.rb')
      if !File.exists?(application_file)
        raise PocketopsError.new('Pocketops must be run inside a Rails application directory. Make sure config/application.rb exists in the current directory.')
      else
        File.readlines(application_file).grep(/^module/).first.split(' ')[1].downcase
      end
    end

    def find_setting(key)
      (@settings['environments'][environment] || {})[:key] || @settings[key]
    end
  end

  def self.config
    @config ||= Config.new('production')
  end
end
