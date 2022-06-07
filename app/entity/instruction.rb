# frozen_string_literal: true

module Entity
  # Instruction entity
  class Instruction
    attr_reader :mnemonic, :operand

    # Initialize the class
    def initialize(mnemonic, operand)
      @mnemonic = mnemonic
      @operand = operand
    end
  end
end
