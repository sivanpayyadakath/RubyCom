# frozen_string_literal: true

require 'entity/instruction'
require 'common/error'

module Stack
  # Stack which stores the instructions
  class InstructionStack
    attr_reader :instruction_arr, :next_addr, :program_counter, :return_addr, :length

    # Initialize the class
    # @param [Integer] length
    def initialize(length)
      @instruction_arr = Array.new(length)
      @next_addr = 0
      @program_counter = 0
      @return_addr = nil
      @length = length
    end

    # Inserts into InstructionStack
    # @param [String] mnemonic
    # @param [Integer] operand
    def insert(mnemonic, operand)
      raise Common::Error::INSTRUCTION_INSERT_FAILED if @next_addr > @length

      @instruction_arr[@next_addr] = Entity::Instruction.new(mnemonic, operand)
      @next_addr += 1
    end

    # Sets next_addr to specified address
    # @param [Integer] address
    def address_set(address)
      raise Common::Error::INSTRUCTION_SET_ADDRESS_FAILED if address > @length

      @next_addr = address
    end

    # Returns next instruction to be executed
    # @return [Entity::Instruction]
    def next_instruction
      # Reached end of instruction stack
      raise Common::Error::INSTRUCTION_GET_NEXT_FAILED if @program_counter > @length

      ins = @instruction_arr[@program_counter]

      # Encountering an empty address
      raise Common::Error::INSTRUCTION_GET_NEXT_FAILED if ins.nil?

      @program_counter += 1
      ins
    end

    # Sets program counter to address
    # @param [Integer] addr
    def call(addr)
      raise Common::Error::INSTRUCTION_CALL_FAILED if addr > @length

      @return_addr = @program_counter
      @program_counter = addr
    end

    # Returns from a function
    # Sets program counter to return address
    def return
      raise Common::Error::INSTRUCTION_RETURN_FAILED if @return_addr.nil?

      @program_counter = @return_addr
      @return_addr = nil
    end

    # Prints the instruction stack
    def print_stack
      puts '___________________'
      @instruction_arr.each_with_index do |i, n|
        puts "#{n + 1} |#{"#{i&.mnemonic} #{i&.operand}".ljust(15, ' ')}|"
        puts '___________________'
      end
    end
  end
end
