require 'tree' #https://github.com/evolve75/RubyTree

class Filesystem

  FILESYSTEM_SIZE = 70000000
  UPGRADE_SIZE = 30000000

  attr_accessor :data, :root, :current_node, :directories_sizes

  def initialize
    @data
    @root = Tree::TreeNode.new("ROOT", "Root Content")
    @current_node = @root
    @directories_sizes = []
  end

  def process!
    read_lines_from_input_file
    parse_data_as_tree
    find_size(100000)
    print
    find_size(10000000000)
    delete_smallest_directory_to_delete
  end

  private

  def parse_data_as_tree
    data.each do |data|
      case data
        when /\$ cd (?<value>\S*)/
          value = data.match(/\$ cd (?<directory>\S*)/)
          directory = value[:directory]
          if directory == '/'
            self.current_node = root
          elsif directory == '..'
            self.current_node = self.current_node.parent
          else
            self.current_node = current_node[directory]
          end
        when /\$ ls/
        else
          content, node_name = data.split(' ')
          self.current_node << Tree::TreeNode.new(node_name, content)
      end
    end
  end

  def find_size(atmost)
    root_size = root.children.map do |node|
      if node.content == 'dir'
        find_directory_size(node, atmost)
      else
        node.content.to_i
      end
    end
    root_directory_size = root_size.compact.inject(:+)
    directories_sizes << root_directory_size if root_directory_size < atmost

  end

  def delete_smallest_directory_to_delete
    root_directory = directories_sizes.pop
    free_space = FILESYSTEM_SIZE - root_directory
    to_be_deleted = UPGRADE_SIZE - free_space
    puts "SMALLEST_DIRECTORY_TO_DELETE: #{directories_sizes.reject! {|e| e < to_be_deleted}.sort.first}"
  end

  def print
    puts "DIRECTORY_SIZE: #{directories_sizes.inject(:+)}"
  end

  def find_directory_size(node, atmost)
    directory_size = 0
    node.children.each do |directory_content|
      directory_size += directory_content.content.to_i unless directory_content.content == 'dir'
      directory_size += find_directory_size(directory_content, atmost) if directory_content.content == 'dir'
    end
    directories_sizes << directory_size if directory_size < atmost
    directory_size
  end

  def file_input
    File.expand_path('input.text', File.dirname(__FILE__))
  end

  def read_lines_from_input_file
    self.data = File.read(file_input).split(/\n/)
  end
end

fs = Filesystem.new
fs.process!
