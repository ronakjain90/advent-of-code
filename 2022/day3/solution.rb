class RuckSack

  attr_accessor :rucksacks, :group_priority, :priority

  def initialize
    @rucksacks = []
    @priority = []
    @group_priority = 0
  end

  def process_priority
    read_lines_from_input_file
    split_compartment_and_find_type
    split_by_group_and_find_type
    print_priority
  end

  private

  def split_compartment_and_find_type
    rucksacks.each do |rucksack|
      priority = rucksack[0..((rucksack.size/2)-1)].chars & rucksack[(rucksack.size/2)..-1].chars
      ascii_value = priority[0].ord
      self.priority << find_priority(ascii_value)
    end
    self.priority = self.priority.inject(:+)
  end

  def split_by_group_and_find_type
    iterator = 0 # 0
    index = self.rucksacks.count # 300
    while(iterator < index)
      priority = rucksacks[iterator].chars & rucksacks[iterator + 1].chars & rucksacks[iterator + 2].chars
      self.group_priority += find_priority(priority[0].ord)
      iterator += 3
    end
  end

  def find_priority(ascii_value)
    if ascii_value >= 65 && ascii_value <= 90
      (ascii_value - 64 + 26)
    else
      (ascii_value - 96)
    end
  end

  def print_priority
    puts "Priority: #{priority}"
    puts "Priority by group: #{group_priority}"
  end

  def file_input
    File.expand_path('input.txt', File.dirname(__FILE__))
  end

  def read_lines_from_input_file
    self.rucksacks = File.read(file_input).split(/\n/)
  end
end

r = RuckSack.new
r.process_priority
