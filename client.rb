#!/usr/bin/env ruby

require "socket"

socket_path = "socket"

def send_command(socket_path, command)
  socket = UNIXSocket.new(socket_path)
  socket.puts(command)
  socket.close
rescue Errno::ECONNREFUSED => e
rescue Errno::ENOENT => e
  puts "Connection refused, how about starting the daemon?"
end

send_command(socket_path, ARGV.join(" "))
