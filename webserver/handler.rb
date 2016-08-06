class Handler
  def self.call(socket, sleep_time: 1)
    # Read the first line of the request (the Request-Line)
    request = socket.gets

    # Log the request to the cosole for debugging
    puts "#{request} => #{Thread.current} (PID: #{Process.pid}): sleeping for #{sleep_time} second"
    sleep sleep_time

    response = "Hello World!\n"

    # We need to include the Content-Type and Content-Length headers
    # to let the client know the size and type of data
    # contained in the response. Note that HTTP is whitespace
    # sensitive, and expects each header line to end with CRLF (i.e. "\r\n")
    socket.print "HTTP/1.1 200 OK\r\n" +
                   "Content-Type: text/plain\r\n" +
                   "Content-Length: #{response.bytesize}\r\n" +
                   "Connection: close\r\n"

    # Print a blank line to separate the header from the response body,
    # as required by the protocol.
    socket.print "\r\n"

    # Print the actual response body, which is just "Hello World!\n"
    socket.print response

    # Close the socket, terminating the connection
    socket.close
  end
end
