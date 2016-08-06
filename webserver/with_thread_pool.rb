require_relative 'handler'
require_relative 'thread_pool'
require 'socket'
require 'thread'

server = TCPServer.new('localhost', 2345)

queue = Queue.new
# Create the Thread Pool to handle concurrent connections
thread_pool = ThreadPool.new(size: 5, queue: queue)

# Pass the block which will be executed by each thread when queue has a job to perform
thread_pool.process do |socket|
  Handler.call(socket)
end

loop do
  socket = server.accept
  queue.push(socket)
end
