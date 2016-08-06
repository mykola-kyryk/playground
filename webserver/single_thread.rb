require 'socket'
require_relative 'handler'

server = TCPServer.new('localhost', 2345)

loop do
  socket = server.accept
  Handler.call(socket)
end
