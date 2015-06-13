#!/usr/bin/env ruby

require "socket"

SOCKET_PATH = ENV.fetch("TEST_RUNNER_SOCKET", "./.test_runner_socket")

def send_command(socket_path, command)
  socket = UNIXSocket.new(socket_path)
  socket.puts(command)
  socket.close
rescue Errno::ECONNREFUSED => e
rescue Errno::ECONNREFUSED => e
  puts "Couldn't open socket #{socket_path}, how about starting the daemon?"
end

send_command(SOCKET_PATH, ARGV.join(" "))
