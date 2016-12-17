module Spree
  class PurchaseOrder < ActiveRecord::Base
    has_one :payment, as: :source

    validates_presence_of :po_number, :organization_name

    def actions
      %w(complete void)
    end

    # Indicates whether its possible to complete the payment
    def can_complete?(payment)
      payment.pending? || payment.checkout?
    end

    # Indicates whether its possible to void the payment.
    def can_void?(payment)
      !payment.failed? && !payment.void?
    end
  end
end
