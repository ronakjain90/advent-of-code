class AssignmentPairs

  attr_accessor :pairs, :fully_contains, :overlap

  def initialize
    @pairs = []
    @fully_contains = []
    @overlap = []
  end

  def process_priority
    read_lines_from_input_file
    split_pairs_and_find_full_contains
    find_overlap
    print
  end

  private

  def split_pairs_and_find_full_contains
    self.fully_contains = pairs.filter do |pair|
      first, second = pair.split(',')
      first_array = eval(first.gsub(/-/,'..')).to_a
      second_array = eval(second.gsub(/-/,'..')).to_a

      (first_array - second_array).empty? || (second_array - first_array).empty?
    end
  end

  def find_overlap
    self.overlap = pairs.filter do |pair|
      first, second = pair.split(',')
      first_array = eval(first.gsub(/-/,'..')).to_a
      second_array = eval(second.gsub(/-/,'..')).to_a
      !(first_array.intersection(second_array).empty?)
    end
  end

  def print
    puts self.fully_contains.count
    puts self.overlap.count
  end


  def file_input
    File.expand_path('input.txt', File.dirname(__FILE__))
  end

  def read_lines_from_input_file
    self.pairs = File.read(file_input).split(/\n/)
  end
end

a = AssignmentPairs.new
a.process_priority
