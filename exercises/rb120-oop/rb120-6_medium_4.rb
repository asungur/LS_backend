# Your task is to write a CircularQueue class that implements a circular queue for arbitrary objects. The class should obtain the buffer size with an argument provided to CircularQueue::new, and should provide the following methods:

# enqueue to add an object to the queue
# dequeue to remove (and return) the oldest object in the queue. It should return nil if the queue is empty

class CircularQueue
  def initialize(size)
    @array = Array.new(size)
    @size = size
  end

  def enqueue(item)
    if array.include? nil
      array << item
    else
      array[0] = nil
      organise
      array << item
    end
    organise
  end

  def dequeue
    if array.count(nil) == size
      return nil
    else
      return array.shift
    end
    organise
  end

  private

  attr_accessor :array
  attr_reader :size
  def organise
    if array.include? nil
      array.delete(nil)
      while array.size < size do 
        array << nil
      end
    end
  end
end
  
  

=begin

ADDING OBJECTS

1. If array is not full: arr << object
2. If array is full: arr[0] = object (replace the oldest object)


REMOVING OBJECTS

1. If not empty arr.shift
2. If empty return nil

ORGANISE

1. If array is not full shift array to the left

=end


queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil