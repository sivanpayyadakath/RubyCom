# frozen_string_literal: true

module Common
  # Error module
  module Error
    INSTRUCTION_INSERT_FAILED = 'A failure occurred when inserting to instruction stack'
    INSTRUCTION_SET_ADDRESS_FAILED = 'A failure occurred when address set was called on instruction stack'
    DATA_PUSH_FAILED = 'A failure occurred when calling push on data stack'
    DATA_POP_FAILED = 'A failure occurred when calling pop on data stack'
    DATA_MULT_FAILED = 'A failure occurred when calling mult on data stack'
  end
end
