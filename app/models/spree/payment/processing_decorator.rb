Spree::Payment::Processing.class_eval do
  def purchase!
    started_processing!
    if source.class == Spree::PurchaseOrder
      gateway_action(source, :authorize, :pend)
    else
      gateway_action(source, :purchase, :complete)
    end
  end
end
