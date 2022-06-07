# frozen_string_literal: true

module Entity
  # Data entity
  class Data
    attr_reader :item

    # Initialize the class
    def initialize(item)
      @item = item
    end
  end
end
