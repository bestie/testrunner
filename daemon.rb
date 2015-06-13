#!/usr/bin/env ruby

require "socket"

SOCKET_PATH = ENV.fetch("TEST_RUNNER_SOCKET", "./.test_runner_socket")

def run_as_command(command)
  Process.wait(
    Process.fork do
      output = []
      pipe = IO.popen(command).each do |line|
        puts line
        output << line
      end

      pipe.close

      # TODO maybe use Open4 to get around this nastiness and handle STDERR better
      exit_code = $?.exitstatus

      puts "%%%%%%%%%%%%% Lines #{output.length}"
      puts "%%%%%%%%%%%%% Total chars #{output.join.length}"
      puts "%%%%%%%%%%%%% Exit code #{exit_code}"
    end
  )
end

File.unlink(SOCKET_PATH)

server = UNIXServer.open(SOCKET_PATH) do |server|
  loop do
    begin
      socket = server.accept
      input = socket.readline
      puts input

      if input == "exit\n"
        puts "Got exit"
        break
      end

      run_as_command(input)
      socket.close
    # rescue EOFError => e
    #   binding.pry
    end
  end
end
