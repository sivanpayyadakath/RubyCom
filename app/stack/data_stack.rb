# frozen_string_literal: true

require 'entity/data'
require 'common/error'

module Stack
  # Stack which stores the data
  class DataStack
    attr_reader :data_arr, :stack_pointer, :length

    # Initialize the class
    # @param [Integer] length
    def initialize(length)
      @data_arr = []
      @stack_pointer = 0
      @length = length
    end

    # Push items into data_stack
    # @param [Integer] item
    # @raise [Common::Error]
    def push(item)
      raise Common::Error::DATA_PUSH_FAILED if @stack_pointer > @length

      @data_arr.push Entity::Data.new(item)
      @stack_pointer += 1
    end

    # Pop item from data_stack
    # @raise [Common::Error]
    # @return [Integer]
    def pop
      raise Common::Error::DATA_POP_FAILED if @stack_pointer.zero?

      data = @data_arr.pop

      @stack_pointer -= 1
      data.item
    end

    # Pops 2 items and pushes their product to data_stack
    # @raise [Common::Error]
    def mult
      raise Common::Error::DATA_MULT_FAILED if @stack_pointer < 2

      item1 = pop
      item2 = pop

      product = item1 * item2
      push(product)
      product
    end

    # Prints the data stack
    def print_stack
      puts '___________________'
      @data_arr.each_with_index do |i, n|
        puts "#{n} |#{"#{i&.item} ".ljust(15, ' ')}|"
        puts '___________________'
      end
    end
  end
end
