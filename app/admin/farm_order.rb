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
      "#{price.price_cents} #{price.price_currency}"
    end
    column 'Date de création de la commande', :created_at
    column 'Status', :status

    column 'Précommande' do |order|
      preorder_array = []
      order.order_line_items.each do |order_line_item|
        if order_line_item.product.available_for_preorder?
          preorder_array << order_line_item.product.preorder
        end
      end
      preorder = preorder_array.max
    end

    column "Expédition", :farm_id do |farm|
      preorder_array = []
      farm.order_line_items.each do |order_line_item|
        if order_line_item.product.available_for_preorder?
          preorder_array << order_line_item.product.preorder
        end
      end
      preorder_array.max
      if farm.farm.accepts_delivery && preorder_array.size >= 1
        l((preorder_array.max + farm.farm.delivery_delay.days), format: '%d %B %Y')
      elsif farm.farm.accepts_delivery
        l((farm.created_at + farm.farm.delivery_delay.days), format: '%d %B %Y')
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
