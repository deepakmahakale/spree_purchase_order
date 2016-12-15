module Spree
  class PurchaseOrder < ActiveRecord::Base
    has_one :payment, as: :source

    validates_presence_of :po_number, :organization_name
  end
end
