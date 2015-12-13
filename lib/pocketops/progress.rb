module Pocketops
  class Progress
    attr_reader :buffer, :exitstatus

    def initialize(number_of_steps = nil)
      @step = 0
      @number_of_steps = number_of_steps
      @buffer = ''
    end

    def parse(stdin, stdout, wait_thr)
      print_start
      while line = stdout.gets do
        parse_line(line)
        @buffer += "#{line}\n"
      end
      @exitstatus = wait_thr.value.exitstatus
      print_end
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
