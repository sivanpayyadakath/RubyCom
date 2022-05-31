# frozen_string_literal: true

module Entity
  class Data
    attr_reader :item

    def initialize(item)
      @item = item
    end
  end
end
