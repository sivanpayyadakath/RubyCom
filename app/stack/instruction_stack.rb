# frozen_string_literal: true

require 'entity/instruction'
require 'common/error'

module Stack
  # Stack which stores the instructions
  class InstructionStack
    attr_reader :instruction_arr, :next_addr, :program_counter, :return_addr

    def initialize(addresses)
      @instruction_arr = Array.new(70 % addresses)
      @next_addr = 0
      @program_counter = 0
      @return_addr = nil
    end

    # Inserts into InstructionStack
    def insert(mnemonic, operand)
      raise Common::Error::INSTRUCTION_INSERT_FAILED if @next_addr > 70

      @instruction_arr[@next_addr] = Entity::Instruction.new(mnemonic, operand)
      @next_addr += 1
    end

    # Sets next_addr to specified address
    def address_set(address)
      raise Common::Error::INSTRUCTION_SET_ADDRESS_FAILED if address > 70

      @next_addr = address
    end

    # Returns next instruction to be executed
    def next_instruction
      raise Common::Error::INSTRUCTION_GET_NEXT_FAILED if @program_counter > 70

      ins = @instruction_arr[@program_counter]
      @program_counter += 1
      ins
    end

    # Sets program counter to address
    def call(addr)
      raise Common::Error::INSTRUCTION_CALL_FAILED if addr > 70

      @return_addr = @program_counter
      @program_counter = addr
    end

    # Returns from a function
    def return
      raise Common::Error::INSTRUCTION_RETURN_FAILED if @return_addr.nil?

      @program_counter = @return_addr
      @return_addr = nil
    end
  end
end
