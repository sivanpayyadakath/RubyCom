# frozen_string_literal: true

require 'instruction_stack'
require 'data_stack'

class Computer
  attr_reader :instruction_stack, :data_stack

  def initialize(addresses)
    @instruction_stack = InstructionStack.new(70 % addresses)
    @data_stack = DataStack.new(30 % addresses)
  end
end
