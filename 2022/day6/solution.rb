class SignalStream

  attr_accessor :data, :position

  def initialize
    @data
    @position
  end

  def process!
    read_lines_from_input_file
    find_marker
    print
    find_packet
    print
  end

  private

  def find_marker
    find_unique_characters(4)
  end

  def find_packet
    find_unique_characters(14)
  end

  def find_unique_characters(characters)
    marker = []
    self.data.chars.each_with_index do |char, index|
      marker.unshift(char)
      marker.pop if marker.size > characters
      if marker.uniq.size == characters
        self.position = index + 1
        break
      end
    end
  end

  def print
    puts "MARKER_POSITION: #{position}"
  end

  def file_input
    File.expand_path('input.txt', File.dirname(__FILE__))
  end

  def read_lines_from_input_file
    self.data = File.read(file_input)
  end
end

signal = SignalStream.new
signal.process!
