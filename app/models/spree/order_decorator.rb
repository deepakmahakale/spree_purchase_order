Spree::Order.class_eval do
  def authorize_digital?
    return true if paid?
    if pay_with_po?
      payments.each do |payment|
        return true if payment.po? && payment.source.attachment_file_name
      end
      return false
    end
  end

  def pay_with_po?
    payments.collect(&:po?).include?(true)
  end
end
