ActiveAdmin.register Order, as: "Commandes"  do
  permit_params :id, :price_cents, :price_currency, :status, :buyer_id

  actions :all
  index do
    actions defaults: true
    column 'Numéro de commande', :id
  end
end
