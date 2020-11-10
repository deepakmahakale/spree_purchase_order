FactoryBot.define do
  sequence :user_authentication_token do |n|
    "xxxx#{Time.current.to_i}#{rand(1000)}#{n}xxxxxxxxxxxxx"
  end

  factory :purchase_order, class: Spree::PurchaseOrder do
    po_number { 'PO-123' }
    organization_name { 'Spree Commerce' }
    association(:payment_method, factory: :purchase_order_payment_method)
  end

  factory :purchase_order_payment_method, class: Spree::PaymentMethod::PurchaseOrder do
    name { 'Purchase Order' }
  end
  factory :payment, class: Spree::Payment do
    amount { 45.75 }
    association(:source, factory: :purchase_order)
    association(:payment_method, factory: :purchase_order_payment_method)
    order
    state { 'checkout' }
    response_code { '12345' }
  end
  factory :order, class: Spree::Order do

    bill_address
    completed_at { nil }
    email { 'email@example.com' }
    store

    transient do
      line_items_price { BigDecimal.new(10) }
    end
  end

  factory :store, class: Spree::Store do
    sequence(:code) { |i| "spree_#{i}" }
    name { 'Spree Test Store' }
    url { 'www.example.com' }
    mail_from_address { 'spree@example.org' }
    default_currency { 'USD' }
  end

  # factory :user, class: Spree.user_class do
  #   email { generate(:random_email) }
  #   login { email }
  #   password 'secret'
  #   password_confirmation { password }
  #   authentication_token { generate(:user_authentication_token) } if Spree.user_class.attribute_method? :authentication_token
  # end
  factory :state, class: Spree::State do
    sequence(:name) { |n| "STATE_NAME_#{n}" }
    sequence(:abbr) { |n| "STATE_ABBR_#{n}" }
    country do |country|
      if usa = Spree::Country.find_by_numcode(840)
        country = usa
      else
        country.association(:country)
      end
    end
  end
  factory :country, class: Spree::Country do
    sequence(:iso_name) { |n| "ISO_NAME_#{n}" }
    sequence(:name) { |n| "NAME_#{n}" }
    iso { 'US' }
    iso3 { 'USA' }
    numcode { 840 }
  end
  factory :address, aliases: [:bill_address, :ship_address], class: Spree::Address do
    firstname { 'John' }
    lastname { 'Doe' }
    company { 'Company' }
    address1 { '10 Lovely Street' }
    address2 { 'Northwest' }
    city { 'Herndon' }
    zipcode { '35005' }
    phone { '555-555-0199' }
    alternative_phone { '555-555-0199' }

    state { |address| address.association(:state) || Spree::State.last }
    country do |address|
      if address.state
        address.state.country
      else
        address.association(:country)
      end
    end
  end
end
