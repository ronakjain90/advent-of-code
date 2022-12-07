class TowerOfCrates

  attr_accessor :data, :instructions, :towers

  def initialize
    @towers = []
    @data
    @instructions
  end

  def process!
    read_lines_from_input_file
    read_towers
    # rearrange_crates
    rearrange_crates_with_same_order
    print_top_crates
  end

  private

  def read_towers
    data
      .split(/\n/)
      .map {|line| line.split(/\s{4}| /) }
      .reverse
      .each_with_index do |level, index|
        next if index == 0
        level.each_with_index do |item, index|
          parsed_item = item.gsub(/\[|\]/,'')
          self.towers[index] = [] if towers[index].nil?
          next if parsed_item.empty?
          self.towers[index] << parsed_item
        end
      end
  end

  def rearrange_crates
    instructions.split(/\n/).each do |instruction|
      data = instruction.match(/move (?<value>\d+) from (?<from>\d+) to (?<to>\d+)/)

      value = data[:value].to_i
      from = data[:from].to_i
      to = data[:to].to_i

      value.times do
        towers[to - 1] << towers[from - 1].pop
      end
    end
  end

  def rearrange_crates_with_same_order
    instructions.split(/\n/).each do |instruction|
      data = instruction.match(/move (?<value>\d+) from (?<from>\d+) to (?<to>\d+)/)

      value = data[:value].to_i
      from = data[:from].to_i
      to = data[:to].to_i

      items = []

      value.times do
        items << towers[from - 1].pop
      end

      towers[to - 1].concat(items.reverse)
    end
  end

  def print_top_crates
    puts "TOP_CRATES: #{towers.map {|m| m.pop}.join('')}"
  end

  def file_input
    File.expand_path('input.txt', File.dirname(__FILE__))
  end

  def read_lines_from_input_file
    self.data, self.instructions = File.read(file_input).split(/\n\n/)
  end
end

toc = TowerOfCrates.new
toc.process!
