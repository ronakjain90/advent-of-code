class Calorie

  attr_accessor :elf

  def initialize
    @elf = []
  end

  def process!
    read_lines_from_input_file
    calculate_elf_with_most_calories
    fetch_calories_from_top_elf
    fetch_calories_from_top_three_elf
  end

  private

  def calculate_elf_with_most_calories
    elf.sort!
  end

  def fetch_calories_from_top_elf
    puts "fetch_calories_from_top_elf: #{elf.last}"
  end

  def fetch_calories_from_top_three_elf
    puts "fetch_calories_from_top_three_elf: #{elf.last(3).inject(:+)}"
  end


  def file_input
    File.expand_path('input.txt', File.dirname(__FILE__))
  end

  def read_lines_from_input_file
    calorie = 0
    File.readlines(file_input).each do |line|
      parsed_line = line.delete("\n")
      calorie += parsed_line.to_i
      if parsed_line.length == 0
        elf << calorie
        calorie = 0
      end
    end
    elf << calorie
  end
end

calorie = Calorie.new
calorie.process!

