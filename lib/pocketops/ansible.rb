module Pocketops
  class Ansible
    attr_reader :executable
    attr_reader :playbooks_path

    def initialize
      @executable = `which ansible-playbook`.strip
      @playbooks_path = File.expand_path(File.join('..', '..', '..', 'ansible'), __FILE__)
      if executable.empty?
        raise PocketopsError.new('Ansible could not be found. Make sure that "which ansible-playbook" returns the location of the ansible-playbook executable.')
      end
    end

    def execute(playbook)
      command =
      ["POCKETOPS_PROJECT_PATH=#{Pocketops.config.root}",
       "ANSIBLE_CONFIG=#{File.join(playbooks_path, 'ansible.cfg')}",
       executable,
       build_params,
       "-i #{inventory}",
       File.join(playbooks_path, playbook.to_s + '.yml'),
       '--check'].compact.join(' ')
      result = `#{command}`
      if $?.exitstatus != 0
        puts "ERROR running #{command}"
        puts "Output:"
        puts result
      else
        puts "OK."
      end
    end

    def inventory
      File.join(playbooks_path, 'inventory')
    end

    private

    def build_params
      Pocketops.config.ansible_vars.map { |key, value| "-e #{key}='#{value}'" }.join(' ')
    end
  end

  def self.ansible
    @ansible ||= Ansible.new
  end
end
