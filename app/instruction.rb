# frozen_string_literal: true

class Instruction
  attr_reader :mnemonic, :operand

  def initialize(mnemonic, operand)
    @mnemonic = mnemonic
    @operand = operand
  end
end
