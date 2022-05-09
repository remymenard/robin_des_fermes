class FarmOrder
  class ShippingPrice
    PRICE_NOT_COMPANION = {
      'takeaway' => Money.new(0,    'CHF'),
      'express'  => Money.new(290, 'CHF'),
      'standard' => Money.new(790, 'CHF')
    }

    PRICE_COMPANION = {
      'takeaway' => Money.new(0,    'CHF'),
      'express'  => Money.new(0, 'CHF'),
      'standard' => Money.new(500, 'CHF')
    }

    attr_reader :price

    def initialize(identifier, price)
      @identifier = identifier
      @price      = price
    end

    class << self
      def all
        PRICE_NOT_COMPANION.map { |identifier, price| self.new(identifier, price) }
      end

      def takeaway
        new('takeaway', PRICE_NOT_COMPANION['takeaway'])
      end

      def express_not_companion
        new('express', PRICE_NOT_COMPANION['express'])
      end

      def standard_not_companion
        new('standard', PRICE_NOT_COMPANION['standard'])
      end

      def express_companion
        new('express', PRICE_COMPANION['express'])
      end

      def standard_companion
        new('standard', PRICE_COMPANION['standard'])
      end
    end
  end
end
