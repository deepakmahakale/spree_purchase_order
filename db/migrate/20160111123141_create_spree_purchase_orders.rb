class CreateSpreePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :spree_purchase_orders do |t|
      t.string :po_number
      t.string :organization_name

      t.timestamps
    end
  end
end
