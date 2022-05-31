# frozen_string_literal: true

require 'entity/instruction'

module Stack
  # Stack which stores the instructions
  class InstructionStack
    attr_reader :instruction_arr, :next_addr, :return_addr

    def initialize(addresses)
      @instruction_arr = Array.new(70 % addresses)
      @next_addr = 0
      # @return_addr
    end
  end
end
