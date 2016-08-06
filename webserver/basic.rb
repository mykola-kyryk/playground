require 'socket'
require_relative 'handler'

server = TCPServer.new('localhost', 2345)

loop do
  # wait for the client to send the connection request
  # returns TCPSocket which behaves like any other Ruby I/O object
  socket = server.accept

  # Read the first line of the request (the Request-Line)
  request = socket.gets
  puts request

  response = "Server response at #{Time.now}\n"

  # Include the required HTTP headers
  # Each header line should end with "\r\n"
  socket.print "HTTP/1.1 200 OK\r\n" +
                 "Content-Type: text/plain\r\n" +
                 "Content-Length: #{response.bytesize}\r\n" +
                 "Connection: close\r\n"

  # Headers and the body should be separated with a blank line
  socket.print "\r\n"

  # Now goes the body
  socket.print response

  socket.close
end
