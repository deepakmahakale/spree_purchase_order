module Spree
  class PurchaseOrder < Spree::Base
    belongs_to :payment_method
    has_many :payments, as: :source

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
