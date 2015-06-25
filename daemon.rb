#!/usr/bin/env ruby

require "socket"

SOCKET_PATH = ENV.fetch("TEST_RUNNER_SOCKET", "./.test_runner_socket")

def run_as_command(command)
  Process.wait(
    Process.fork {
      exec(command)
    }
  )
end

File.unlink(SOCKET_PATH)

UNIXServer.open(SOCKET_PATH) do |server|
  loop do
    begin
      socket = server.accept
      input = socket.readline
      puts input

      if input == "exit\n"
        puts "Exiting ..."
        break
      end

      run_as_command(input)
    rescue Interrupt
      break
    ensure
      socket && socket.close
    end
  end
end
