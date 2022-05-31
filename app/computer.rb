# frozen_string_literal: true

require 'stack/instruction_stack'
require 'stack/data_stack'

class Computer
  attr_reader :instruction_stack, :data_stack

  def initialize(addresses)
    @instruction_stack = Stack::InstructionStack.new(70 % addresses)
    @data_stack = Stack::DataStack.new(30 % addresses)
  end

  def insert(mnemonic, operand = nil)
    @instruction_stack.insert(mnemonic, operand)
    self
  end

  def address_set(address)
    @instruction_stack.address_set(address)
    self
  end

  # def execute
  # end
end
