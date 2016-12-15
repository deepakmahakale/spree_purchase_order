class AddUserIdToSpreePurchaseOrders < ActiveRecord::Migration
  def change
    add_column :spree_purchase_orders, :user_id, :integer
    add_index :spree_purchase_orders, :user_id
  end
end
