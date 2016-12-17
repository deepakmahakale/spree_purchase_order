Spree::Payment.class_eval do
  scope :from_purchase_order, -> { where(source_type: 'Spree::PurchaseOrder') }

  def po?
    source_type == 'Spree::PurchaseOrder'
  end
end
