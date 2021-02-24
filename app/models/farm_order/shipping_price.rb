class FarmOrder
  class ShippingPrice
    DATA = {
      'takeaway' => Money.new(0,    'CHF'),
      'express'  => Money.new(290, 'CHF'),
      'standard' => Money.new(990, 'CHF')
    }

    attr_reader :price

    def initialize(identifier, price)
      @identifier = identifier
      @price      = price
    end

    class << self
      def all
        DATA.map { |identifier, price| self.new(identifier, price) }
      end

      def takeaway
        new('takeaway', DATA['takeaway'])
      end

      def express
        new('express', DATA['express'])
      end

      def standard
        new('standard', DATA['standard'])
      end
    end
  end
end
