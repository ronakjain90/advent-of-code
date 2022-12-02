class Calorie

  attr_accessor :elfs

  def initialize
    @elfs = []
  end

  def process!
    read_lines_from_input_file
    calculate_elf_with_most_calories
    fetch_calories_from_top_elf
    fetch_calories_from_top_three_elf
  end

  private

  def calculate_elf_with_most_calories
    self.elfs = elfs.map do |elf|
      elf.split(/\n/).map(&:to_i).inject(:+)
    end.sort!
  end

  def fetch_calories_from_top_elf
    puts "fetch_calories_from_top_elf: #{elfs.last}"
  end

  def fetch_calories_from_top_three_elf
    puts "fetch_calories_from_top_three_elf: #{elfs.last(3).inject(:+)}"
  end


  def file_input
    File.expand_path('input.txt', File.dirname(__FILE__))
  end

  def read_lines_from_input_file
    self.elfs = File.read(file_input).split(/\n\n/)
  end
end

calorie = Calorie.new
calorie.process!

