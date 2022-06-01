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
end
