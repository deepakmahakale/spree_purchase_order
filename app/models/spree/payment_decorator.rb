Spree::Payment.class_eval do
  has_one :purchase_order

  def po?
    payment_method.type == 'Spree::PaymentMethod::PurchaseOrder'
  end
end
