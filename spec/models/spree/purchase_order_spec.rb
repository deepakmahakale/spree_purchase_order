require 'spec_helper'

describe Spree::PurchaseOrder, type: :model do
  let(:valid_purchase_order_attributes) do
    {
      po_number: 'PO-123',
      organization_name: 'Spree Commerce'
    }
  end

  def self.payment_states
    Spree::Payment.state_machine.states.keys
  end

  let(:purchase_order) { Spree::PurchaseOrder.new }

  context "#can_complete?" do
    it "should be true if payment is pending" do
      payment = create(:payment, state: 'pending')
      expect(purchase_order.can_complete?(payment)).to be true
    end

    it "should be true if payment is checkout" do
      payment = create(:payment, state: 'checkout')
      expect(purchase_order.can_complete?(payment)).to be true
    end
  end

  context "#can_void?" do
    it "should be true if payment is not void" do
      payment = create(:payment, state: 'checkout')
      expect(purchase_order.can_void?(payment)).to be true
    end
  end

  context "#valid?" do
    it "should validate presence of po number" do
      purchase_order.attributes = valid_purchase_order_attributes.except(:po_number)
      expect(purchase_order).not_to be_valid
      expect(purchase_order.errors[:po_number]).to eq(["can't be blank"])
    end

    it "should validate presence of organization name" do
      purchase_order.attributes = valid_purchase_order_attributes.except(:organization_name)
      expect(purchase_order).not_to be_valid
      expect(purchase_order.errors[:organization_name]).to eq(["can't be blank"])
    end

    it "should only validate on create" do
      purchase_order.attributes = valid_purchase_order_attributes
      purchase_order.save
      expect(purchase_order).to be_valid
    end
  end

  context "#associations" do
    it "should be able to access its payments" do
      expect { purchase_order.payments.to_a }.not_to raise_error
    end
  end
end
