module Spree
  class PurchaseOrder < ActiveRecord::Base
    has_one :payment, as: :source
    attr_accessible :po_number, :organization_name
    validates_presence_of :po_number, :organization_name
  end
end
