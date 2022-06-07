# frozen_string_literal: true

require 'rspec'
require 'stack/data_stack'
require 'entity/data'

describe Stack::DataStack do
  describe '.push' do
    context 'successfully calls push method' do
      it 'Inserts into stack and increments stack_pointer' do
        stack = Stack::DataStack.new(30)

        stack.push(100)

        expect(stack.instance_variable_get(:@stack_pointer)).to eq(1)
        expect(stack.instance_variable_get(:@data_arr)[0].item).to eq(100)
        expect(stack.instance_variable_get(:@data_arr)).to all(be_an(Entity::Data))
      end
    end

    context 'Push fails when stack is full' do
      it 'raises an error' do
        stack = Stack::DataStack.new(30)

        stack.instance_variable_set(:@stack_pointer, 31)

        expect do
          stack.push(100)
        end.to raise_error(RuntimeError, Common::Error::DATA_PUSH_FAILED)
      end
    end
  end

  describe '.pop' do
    context 'successfully calls pop method' do
      it 'Pop from stack and decrements stack_pointer' do
        stack = Stack::DataStack.new(30)
        stack.push(1)
        stack.push(2)

        expect do
          result = stack.pop
          expect(result).to eq(2)
        end.to change { stack.instance_variable_get(:@stack_pointer) }.by(-1)
      end
    end

    context 'Pop fails when stack is empty' do
      it 'raises an error' do
        stack = Stack::DataStack.new(30)

        expect do
          stack.pop
        end.to raise_error(RuntimeError, Common::Error::DATA_POP_FAILED)
      end
    end
  end

  describe '.mult' do
    context 'successfully calls mult method' do
      it 'Returns product of last 2 elements from stack and decrements stack_pointer by 1' do
        stack = Stack::DataStack.new(30)
        stack.push(10)
        stack.push(20)

        expect do
          result = stack.mult
          expect(result).to eq(200)
        end.to change { stack.instance_variable_get(:@stack_pointer) }.by(-1)
      end
    end

    context 'Mult fails when stack size is less than 2' do
      it 'raises an error' do
        stack = Stack::DataStack.new(30)
        stack.push(10)

        expect do
          stack.mult
        end.to raise_error(RuntimeError, Common::Error::DATA_MULT_FAILED)
      end
    end
  end
end
