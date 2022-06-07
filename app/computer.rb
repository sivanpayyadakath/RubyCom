# frozen_string_literal: true

require 'stack/instruction_stack'
require 'stack/data_stack'
require 'common/error'

# Computer simulator class
class Computer
  attr_reader :instruction_stack, :data_stack

  # Initialize the class
  # TODO
  def initialize(addresses)
    @instruction_stack = Stack::InstructionStack.new(70 % addresses)
    @data_stack = Stack::DataStack.new(30 % addresses)
  end

  # Inserts an instruction into instruction_stack
  # @param [String] mnemonic
  # @param [Integer] operand
  def insert(mnemonic, operand = nil)
    @instruction_stack.insert(mnemonic, operand)
    self
  end

  # Sets next_address on instruction_stack
  # @param [Integer] address
  def address_set(address)
    @instruction_stack.address_set(address)
    self
  end

  # Executes from instruction_stack until STOP is encountered
  def execute
    puts "INSTRUCTION STACK BEFORE EXECUTE\n\n"
    @instruction_stack.print_stack

    puts "\n\n\n\n\nOUTPUT===========\n"
    ins = @instruction_stack.next_instruction
    while ins.mnemonic != 'STOP'
      run(ins.mnemonic, ins.operand)
      ins = @instruction_stack.next_instruction
    end
  rescue RuntimeError => e
    puts "RuntimeError occurred while running the program: #{e} \n Exiting"
  end

  # Run a specific instruction
  # @param [String] mnemonic
  # @param [Integer] operand
  def run(mnemonic, operand = nil)
    case mnemonic
    when 'PUSH'
      @data_stack.push(operand)
    when 'PRINT'
      item = @data_stack.pop
      puts "# #{item}"
    when 'MULT'
      @data_stack.mult
    when 'CALL'
      @instruction_stack.call(operand)
    when 'RET'
      @instruction_stack.return
    else
      raise Common::Error::INSTRUCTION_RUN_FAILED
    end

    # Uncomment to see data stack after each instruction execution
    # p "DATA STACK AFTER RUNNING INSTRUCTION #{mnemonic} #{operand}"
    # @data_stack.print_stack
  end
end
