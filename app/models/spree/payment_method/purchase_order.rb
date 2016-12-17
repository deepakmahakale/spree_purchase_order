module Spree
  class PaymentMethod::PurchaseOrder < PaymentMethod
    def payment_source_class
      Spree::PurchaseOrder
    end

    def authorize(*args)
      simulated_successful_billing_response('Purchase Order: Success')
    end

    def void(*args)
      simulated_successful_billing_response
    end

    def source_required?
      true
    end

    def auto_capture?
      false
    end

    private

    def simulated_successful_billing_response(message = "")
      ActiveMerchant::Billing::Response.new(true, message, {}, {})
    end
  end
end
