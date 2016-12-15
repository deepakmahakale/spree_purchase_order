class AddPaymentMethodIdToSpreePurchaseOrders < ActiveRecord::Migration
  def change
    add_column :spree_purchase_orders, :payment_method_id, :integer
    add_index :spree_purchase_orders, :payment_method_id
  end
end
