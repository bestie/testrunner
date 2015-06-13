require "pry"
require "socket"

socket_path = "socket"

server = UNIXServer.new(socket_path)

loop do
  begin
    socket = server.accept
    input = socket.readline
    puts input
    if input == "exit\n"
      puts "Got exit"
      socket.close
      break
    end
  rescue EOFError => e
  end
end

server.close