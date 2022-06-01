# frozen_string_literal: true

require 'entity/data'
require 'common/error'

module Stack
  class DataStack
    attr_reader :data_arr, :stack_pointer

    def initialize(addresses)
      @data_arr = Array.new(30 % addresses)
      @stack_pointer = 0
    end

    def push(item)
      raise Common::Error::DATA_PUSH_FAILED if @stack_pointer > 30

      @data_arr << Entity::Data.new(item)
      @stack_pointer += 1
    end

    def pop
      raise Common::Error::DATA_POP_FAILED if @stack_pointer.zero?

      @data_arr.pop
      @stack_pointer -= 1
    end

    def mult
      raise Common::Error::DATA_MULT_FAILED if @stack_pointer < 2

      item1 = @data_arr.pop
      item2 = @data_arr.pop
      @stack_pointer -= 2
      item1.item * item2.item
    end
  end
end
