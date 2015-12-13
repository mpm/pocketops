require 'open3'
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

    def execute(playbook, options = {})
      if options[:sudo_password]
        options[:vars] ||= {}
        options[:vars][:ansible_sudo_pass] = options[:sudo_password]
      end
      command =
      ["POCKETOPS_PROJECT_PATH=#{Pocketops.config.root}",
       "ANSIBLE_CONFIG=#{File.join(playbooks_path, 'ansible.cfg')}",
       executable,
       build_params(options[:vars] || {}),
       "-i #{inventory}",
       File.join(options[:path] || playbooks_path, playbook.to_s + '.yml'),
       options[:check] ? '--check' : nil,
      ].compact.join(' ')
      p = Progress.new(options[:total_steps])
      Open3.popen2(command) do |stdin, stdout, wait_thr|
        p.parse(stdin, stdout, wait_thr)
      end

      if p.exitstatus != 0
        raise PocketopsError.new(
          ['Error running Ansible.',
           'Command line:',
           command,
           '',
           "Exit status: #{p.exitstatus}",
           '',
           'Output:',
           "#{p.buffer}"].join("\n"))
      else
        return true, p.buffer
      end
    end

    def inventory
      File.join(playbooks_path, '..', 'exe', 'pocketops-inventory')
    end

    private

    def build_params(vars = {})
      Pocketops.config.ansible_vars.merge(vars).map { |key, value| "-e #{key}='#{value}'" }.join(' ')
    end
  end

  def self.ansible
    @ansible ||= Ansible.new
  end
end
