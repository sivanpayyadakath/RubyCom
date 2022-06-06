require 'rspec'
require 'computer'
require 'entity/instruction'

describe Computer do
  let(:instruction_stack) { double('Stack::InstructionStack') }

  describe '.insert' do
    context 'successfully calls InstructionStack.insert method' do
      it 'Inserts into InstructionStack and returns self' do
        computer = Computer.new(100)
        computer.instance_variable_set(:@instruction_stack, instruction_stack)

        expect(instruction_stack).to receive(:insert).with('PUSH', 100)

        result = computer.insert 'PUSH', 100

        expect(result).to eq computer
      end

      context 'raises error if  into InstructionStack.insert raises error' do
        it 'raises error' do
          computer = Computer.new(100)
          computer.instance_variable_set(:@instruction_stack, instruction_stack)

          expect(instruction_stack).to receive(:insert).with('PUSH',
                                                             100).and_raise(Common::Error::INSTRUCTION_INSERT_FAILED)

          expect do
            computer.insert 'PUSH', 100
          end.to raise_error(RuntimeError, Common::Error::INSTRUCTION_INSERT_FAILED)
        end
      end
    end
  end

  describe '.address_set' do
    context 'successfully calls InstructionStack.next_address' do
      it 'Sets address and returns self' do
        computer = Computer.new(100)
        computer.instance_variable_set(:@instruction_stack, instruction_stack)

        expect(instruction_stack).to receive(:address_set).with(30)

        result = computer.address_set(30)

        expect(result).to eq computer
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

  describe '.execute' do
    context 'Executes from instruction_stack until STOP is encountered' do
      it 'executes instruction from stack' do
        computer = Computer.new(100)
        ins_stack = computer.instance_variable_get(:@instruction_stack)

        expect(ins_stack).to receive(:next_instruction).and_return(Entity::Instruction.new('PUSH', 1)).exactly(2).times
        expect(ins_stack).to receive(:next_instruction).and_return(Entity::Instruction.new('STOP',
                                                                                           nil)).exactly(1).times
        expect(ins_stack).to receive(:print_stack)

        computer.execute
      end
    end

    context 'Doesnt raise error when next_instruction raises error' do
      it 'error is handled correctly' do
        computer = Computer.new(100)
        ins_stack = computer.instance_variable_get(:@instruction_stack)

        expect(ins_stack).to receive(:next_instruction).and_raise(Common::Error::INSTRUCTION_GET_NEXT_FAILED).exactly(1).times
        expect(ins_stack).to receive(:print_stack)

        expect do
          computer.execute
        end.not_to raise_error
      end
    end
  end

  describe '.run' do
    context 'Runs an individual instruction from stack' do
      it 'runs a PUSH instruction' do
        computer = Computer.new(100)
        data_stack = computer.instance_variable_get(:@data_stack)

        expect(data_stack).to receive(:push).with(1)
        computer.run('PUSH', 1)
      end

      it 'runs a PRINT instruction' do
        computer = Computer.new(100)
        data_stack = computer.instance_variable_get(:@data_stack)

        expect(data_stack).to receive(:pop)
        computer.run('PRINT')
      end

      it 'runs a PRINT instruction' do
        computer = Computer.new(100)
        data_stack = computer.instance_variable_get(:@data_stack)

        expect(data_stack).to receive(:pop)
        computer.run('PRINT')
      end

      it 'runs a MULT instruction' do
        computer = Computer.new(100)
        data_stack = computer.instance_variable_get(:@data_stack)

        expect(data_stack).to receive(:mult)
        computer.run('MULT')
      end

      it 'runs a CALL instruction' do
        computer = Computer.new(100)
        instruction_stack = computer.instance_variable_get(:@instruction_stack)

        expect(instruction_stack).to receive(:call).with(50)
        computer.run('CALL', 50)
      end

      it 'runs a RET instruction' do
        computer = Computer.new(100)
        instruction_stack = computer.instance_variable_get(:@instruction_stack)

        expect(instruction_stack).to receive(:return)
        computer.run('RET')
      end
    end

    context 'Raises error when unsupported instruction is passed' do
      it 'raises error' do
        computer = Computer.new(100)

        expect do
          computer.run('LOAD')
        end.to raise_error(RuntimeError, Common::Error::INSTRUCTION_RUN_FAILED)
      end
    end
  end
end
