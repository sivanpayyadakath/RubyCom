# frozen_string_literal: true

require 'entity/instruction'
require 'common/error'

module Stack
  # Stack which stores the instructions
  class InstructionStack
    attr_reader :instruction_arr, :next_addr, :return_addr

    def initialize(addresses)
      @instruction_arr = Array.new(70 % addresses)
      @next_addr = 0
      # @return_addr
    end

    def insert(mnemonic, operand)
      raise Common::Error::INSTRUCTION_INSERT_FAILED if @next_addr > 70

      @instruction_arr[@next_addr] = Entity::Instruction.new(mnemonic, operand)
      @next_addr += 1
    end

    def address_set(address)
      raise Common::Error::INSTRUCTION_INSERT_FAILED if address > 70

      @next_addr = address
    end
  end
end
