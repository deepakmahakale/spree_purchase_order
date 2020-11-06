module Spree
  module PaymentDecorator
    def self.prepended(base)
      base.scope :from_purchase_order, -> { where(source_type: 'Spree::PurchaseOrder') }
    end

    def po?
      source_type == 'Spree::PurchaseOrder'
    end
  end
end

if ::Spree::Payment.included_modules.exclude?(::Spree::PaymentDecorator)
  ::Spree::Payment.prepend ::Spree::PaymentDecorator
end
