class AddPoNumberToSpreePayments < ActiveRecord::Migration
  def change
    add_column :spree_payments, :po_number, :string
  end
end
