#!/usr/bin/env ruby

require "socket"

SOCKET_PATH = ENV.fetch("TEST_RUNNER_SOCKET", "./.test_runner_socket")

def run_as_command(command)
  Process.wait(
    Process.fork do
      Process.exec(command)
    end
  )
end

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
