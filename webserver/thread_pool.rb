require 'thread'

class ThreadPool
  attr_reader :size, :queue

  def initialize(size:, queue: Queue.new)
    @size = size
    @queue = queue
  end

  def process(&block)
    @workers = []

    @size.times do |thread_number|
      @workers << Thread.new do
        begin
          while job = queue.pop
            puts "Worker #{thread_number + 1}"
            block.call(job)
          end
        rescue ThreadError
        end
      end
    end

    @workers.map(&:join)
  end

  def stop
    @queue.close # if thread can not read from the queue - it dies.
  end
end
