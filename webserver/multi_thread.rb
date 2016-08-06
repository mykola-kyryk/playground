require_relative 'handler'
require 'socket'
require 'thread'

server = TCPServer.new('localhost', 2345)

loop do
  Thread.start(server.accept) do |socket|
    Handler.call(socket)
  end
end
