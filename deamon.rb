require "pry"
require "socket"

socket_path = "socket"

serv = UNIXServer.new(socket_path)

loop do
  s = serv.accept
  input = s.readline
  puts input
  if input == "exit\n"
    puts "Got exit"
    s.close
    break
  end
end
