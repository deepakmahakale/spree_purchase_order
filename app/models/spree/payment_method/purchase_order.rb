module Spree
  class PaymentMethod::PurchaseOrder < PaymentMethod
    def payment_source_class
      Spree::PurchaseOrder
    end

    def actions
      %w(complete void)
    end

    def can_complete?(payment)
      %w(checkout pending).include?(payment.state)
    end

    def can_void?(payment)
      payment.state != 'void'
    end

    def authorize(*args)
      ActiveMerchant::Billing::Response.new(true, 'Purchase Order: Success', {}, {})
    end

    def complete(*)
      ActiveMerchant::Billing::Response.new(true, 'Purchase Order: Success', {}, {})
    end

    def void(*args)
      ActiveMerchant::Billing::Response.new(true, '', {}, {})
    end

    def source_required?
      true
    end

    def auto_capture?
      false
    end
  end
end
