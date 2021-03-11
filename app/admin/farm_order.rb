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
      if farm.order.buyer.present?
        farm.order.buyer.first_name + " " + farm.order.buyer.last_name
      end
    end

    column 'Montant' do |price|
      "#{price.price} #{price.price_currency}"
    end

    column 'Date de création de la commande', :created_at

    column 'Status', :status do |farm_order|
      t("farm_orders.statuses.#{farm_order.status}")
    end

    column 'Précommande' do |farm_order|
      farm_order.preordered_products_max_shipping_starting_at
    end

    column "Expédition", :farm_id do |farm_order|

    end

    column 'Commentaire', :comment
  end

  show do
    attributes_table do
      row "A retirer à l'exploitation", &:takeaway_at_farm
      row "Livraison standard", &:standard_shipping
      row "Livraison express", &:express_shipping
      row "Prix en centimes", &:price_cents
      row "Unité", &:price_currency
      row "En attente d'expédition chez", &:waiting_for_shipping_at
      row "Expédié à", &:shipped_at
      row "Problème soulevé à", &:issue_raised_at
      row "Numéro de commande", &:order


      row "Exploitation", :farm_id do |order|
        order.farm.name
      end

      row "Nom du client", :order_id do |order|
        order.order.buyer.first_name + " " + order.order.buyer.last_name
      end

      row "Adresse du client", :buyer_id do |order|
        order.order.buyer.address_line_1 + " " + order.order.buyer.zip_code + " " + order.order.buyer.city
      end

      row "Crée", &:created_at
      row "Modifié", &:updated_at
      row "Prix de livraison en centimes", &:shipping_price_cents
      row "Unité", &:shipping_price_currency
      row "status", &:status
      row "Commentaire", &:comment
      row "En attente de précommande sur", &:waiting_for_preorder_at
      row "Confirmation de l'expédition", &:confirm_shipped_token
    end
  end

  form title: 'commandes' do |farm_order_form|
    panel 'Commentaire' do
      farm_order_form.input :comment, label: false
    end

    panel 'Status' do
      options_with_display = farm_order_form.object.shipping_status_options.map do |option|
        [t("farm_orders.statuses.#{option}"), option]
      end.to_h

      farm_order_form.input :status, as: :select, label: false, collection: options_with_display
    end

    farm_order_form.actions do
      if resource.persisted?
        farm_order_form.action :submit, label: "Modifier la commande"
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
