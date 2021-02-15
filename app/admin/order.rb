ActiveAdmin.register FarmOrder, as: "Commandes"  do
  permit_params :id, :takeaway_at_farm, :standard_shipping, :express_shipping, :price_cents, :price_currency, :waiting_for_shipping_at, :shipped_at, :issue_raised_at, :status, :order_id, :farm_id, :shipping_price_cents, :shipping_price_currency

  actions :all
  index do
    actions defaults: true
    column 'Numéro de commande', :id
  end
end
