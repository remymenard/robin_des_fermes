ActiveAdmin.register FarmOrder, as: "Commandes"  do
  permit_params :id, :takeaway_at_farm, :comment, :standard_shipping, :express_shipping, :price_cents, :price_currency, :waiting_for_shipping_at, :shipped_at, :issue_raised_at, :status, :order_id, :farm_id, :shipping_price_cents, :shipping_price_currency

  actions :all
  index do
    actions defaults: true

    column 'Numéro de commande', :id

    column "Nom de l'exploitant", :farm_id do |farm|
      farm.farm.user.first_name + " " + farm.farm.user.last_name
    end

    column "Nom du consommateur", :order_id do |farm|
      farm.order.buyer.first_name + " " + farm.order.buyer.last_name
    end

    column 'Montant' do |price|
      "#{price.price} #{price.price_currency}"
    end

    column 'Date de création de la commande', :created_at
    column 'Status', :status

    column 'Précommande' do |farm_order|
      farm_order.preordered_products_max_shipping_starting_at
    end

    column "Expédition", :farm_id do |farm_order|
      if farm_order.farm.accepts_delivery && farm_order.with_preordered_products?
        shipping_date = farm_order.preordered_products_max_shipping_starting_at + farm_order.farm.delivery_delay.days
        l(shipping_date, format: '%d %B %Y')

      elsif farm_order.farm.accepts_delivery
        shipping_date = farm_order.created_at + farm_order.farm.delivery_delay.days
        l(shipping_date, format: '%d %B %Y')
      end
    end

    column 'Commentaire', :comment
  end

  form title: 'commandes' do |order|
    panel 'Commentaire' do
      order.input :comment, label: false
    end

    panel 'Status' do
      if order.object.takeaway_at_farm?
        order.input :status, label: false, collection: ["En préparation", "Prête à être retirée", "Retirée", "Payée", "Annulée"]
      else
        order.input :status, label: false, collection: ["En préparation", "Expédiée", "Reçue", "Payée", "Annulée"]
      end
    end

    order.actions do
      if resource.persisted?
        order.action :submit, label: "Modifier la commande"
      end
    end
  end

  controller do

    def update
      @farm_order = FarmOrder.find(params[:id])
      @farm_order.assign_attributes(permitted_params[:farm_order])

      if @farm_order.save
        redirect_to admin_commandes_path
      else
        @resource = @farm_order
        render :edit
      end
    end
  end
end
