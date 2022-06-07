# frozen_string_literal: true

require 'rspec'
require 'stack/instruction_stack'
require 'entity/instruction'

describe Stack::InstructionStack do
  describe '.insert' do
    context 'successfully calls insert method' do
      it 'Inserts into stack and increments next_addr' do
        stack = Stack::InstructionStack.new(70)

        stack.insert('PUSH', 100)

        expect(stack.instance_variable_get(:@next_addr)).to eq(1)
        expect(stack.instance_variable_get(:@instruction_arr)[0]).to be_instance_of(Entity::Instruction)
      end
    end

    context 'Insert fails when stack is full' do
      it 'raises an error' do
        stack = Stack::InstructionStack.new(70)

        stack.instance_variable_set(:@next_addr, 71)

        expect do
          stack.insert('PUSH', 100)
        end.to raise_error(RuntimeError, Common::Error::INSTRUCTION_INSERT_FAILED)
      end
    end
  end

  describe '.address_set' do
    context 'successfully sets next_address' do
      it 'Sets next_addr to given address' do
        stack = Stack::InstructionStack.new(70)

        stack.address_set(30)

        expect(stack.instance_variable_get(:@next_addr)).to eq(30)
      end
    end

    context 'address_set fails when address is out of bounds' do
      it 'raises an error' do
        stack = Stack::InstructionStack.new(70)

        expect do
          stack.address_set(71)
        end.to raise_error(RuntimeError, Common::Error::INSTRUCTION_SET_ADDRESS_FAILED)
      end
    end
  end

  describe '.next_instruction' do
    context 'successfully returns the next instruction to be executed' do
      it 'Returns instruction stack and increments program_counter' do
        stack = Stack::InstructionStack.new(70)

        stack.insert('PUSH', 100)

        result = stack.next_instruction

        expect(stack.instance_variable_get(:@program_counter)).to eq(1)
        expect(result.mnemonic).to eq('PUSH')
        expect(result.operand).to eq(100)
        expect(result).to be_instance_of(Entity::Instruction)
      end
    end

    context 'next_instruction fails at end of stack' do
      it 'raises an error' do
        stack = Stack::InstructionStack.new(70)

        stack.instance_variable_set(:@program_counter, 71)

        expect do
          stack.next_instruction
        end.to raise_error(RuntimeError, Common::Error::INSTRUCTION_GET_NEXT_FAILED)
      end
    end

    context 'next_instruction fails when no instruction is found' do
      it 'raises an error' do
        stack = Stack::InstructionStack.new(70)

        expect do
          stack.next_instruction
        end.to raise_error(RuntimeError, Common::Error::INSTRUCTION_GET_NEXT_FAILED)
      end
    end
  end

  describe '.call' do
    context 'successfully sets program counter to addr' do
      it 'Sets program_counter and return_address' do
        stack = Stack::InstructionStack.new(70)

        stack.instance_variable_set(:@program_counter, 10)

        stack.call(35)

        expect(stack.instance_variable_get(:@program_counter)).to eq(35)
        expect(stack.instance_variable_get(:@return_addr)).to eq(10)
      end
    end

    context 'call fails when invalid address is specified' do
      it 'raises an error' do
        stack = Stack::InstructionStack.new(70)

        expect do
          stack.call(90)
        end.to raise_error(RuntimeError, Common::Error::INSTRUCTION_CALL_FAILED)
      end
    end
  end

  describe '.return' do
    context 'successfully returns from a routine' do
      it 'Sets program_counter and resets return_address' do
        stack = Stack::InstructionStack.new(70)

        stack.instance_variable_set(:@program_counter, 10)
        stack.call(30)

        expect(stack.instance_variable_get(:@program_counter)).to eq(30)
        expect(stack.instance_variable_get(:@return_addr)).to eq(10)

        stack.return

        expect(stack.instance_variable_get(:@program_counter)).to eq(10)
        expect(stack.instance_variable_get(:@return_addr)).to eq(nil)
      end
    end

    context 'return fails when return_address is nil' do
      it 'raises an error' do
        stack = Stack::InstructionStack.new(70)

        expect do
          stack.return
        end.to raise_error(RuntimeError, Common::Error::INSTRUCTION_RETURN_FAILED)
      end
    end
  end
end
