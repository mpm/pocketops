require 'pty'
module Pocketops
  class Progress
    attr_reader :buffer, :exitstatus

    def initialize(number_of_steps = nil)
      @step = 0
      @number_of_steps = number_of_steps
      @buffer = ''
    end

    def execute(command)
      print_start
      begin
        PTY.spawn(command) do |stdin, stdout, pid|
          parse(stdin, stdout, pid)
          Process.wait(pid)
        end
      rescue Errno::EIO
      end
      @exitstatus = $?
      print_end
    end

    def parse(stdin, stdout, pid)
      while line = stdin.gets do
        parse_line(line)
        @buffer += "#{line}\n"
      end
    end

    private

    def parse_line(line)
      if line =~ /^TASK:/
        s = line.split('[').last.split(']').first
        print_updated_status(s)
      end
    end

    def print_start
      print 'connecting...'
    end

    def print_updated_status(status)
      @step += 1
      print ansi_clear_line
      if @number_of_steps
        print "[#{@step}/#{@number_of_steps}] "
      end
      print status
    end

    def print_end
      print ansi_clear_line
      puts "OK."
    end

    def ansi_clear_line
      "\033[2K\r"
    end
  end
end
