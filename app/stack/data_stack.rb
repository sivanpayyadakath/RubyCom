# frozen_string_literal: true

require 'entity/data'

module Stack
  class DataStack
    attr_reader :data_arr, :stack_pointer

    def initialize(_addresses)
      @data_arr = []
      # Array.new(30 % addresses)
      @stack_pointer = 0
    end
  end
end
