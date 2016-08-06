require 'socket'
require_relative 'handler'

server = TCPServer.new('localhost', 2345)

at_exit { Process.wait }

loop do
  socket = server.accept

  fork do
    #server.close
    Handler.call(socket, sleep_time: 10)
    Kernel.exit!
  end

  #socket.close
end
