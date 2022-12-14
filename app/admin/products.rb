ActiveAdmin.register Product, as: 'Produits' do
  permit_params :id, :farm_id, :name, :available, :category_id, :product_subcategory_id, :photo, :description, :ingredients, :unit, :fresh, :price_per_unit_cents, :price_per_unit_currency, :price_cents, :price_currency, :subtitle, :minimum_weight, :display_minimum_weight, :conditioning, :preorder_shipping_starting_at, :total_weight, :available_for_preorder, label: []
  actions :all
  index do
    actions defaults: true
    column 'En stock', :available
    column 'Nom du produit', :name
    column :farm_id do |product|
      product.farm.name
    end
    column :category, sortable: true
    column 'Prix (CHF)', :price, sortable: true
  end

  filter :farm, label: 'Ferme'
  filter :category, label: 'Catégorie'

  form title: 'Produit' do |product|
    panel 'Informations sur le produit' do
      product.input :farm, label: 'Ferme'
      product.input :available, label: 'En stock ?'
      product.input :name, label: 'Nom'
      product.input :category_id, as: :select, collection: Category.all, label: 'Catégorie'
      product.input :product_subcategory_id, as: :select, collection: ProductSubcategory.where(farm: resource.farm), label: "Sous-catégorie"
      product.input :price_cents, label: 'Prix CHF'
      product.input :display_minimum_weight, label: 'Afficher poids Minimum ?'
      product.input :minimum_weight, label: 'Poids ou volume'
      product.input :unit, label: 'Unité'
      product.input :price_per_unit_cents, label: 'Prix au kg'
      product.input :conditioning, label: 'Conditionnement'
      product.input :fresh, label: 'Frais'
      product.input :label, label: 'Label', as: :check_boxes, collection: Farm::LABELS
      product.input :available_for_preorder, label: "Disponible en précommande"
      product.input :preorder_shipping_starting_at, label: 'Date livraison précommande'
      product.input :description, label: 'Description'
      product.input :ingredients, label: 'Ingrédients'
      if product.object.photo.attached?
        product.input :photo, as: :file, label: "Changer l'image du produit", hint: image_tag(cl_image_path(product.object.photo.key), height: 256)
      else
        product.input :photo, as: :file, label: 'Image du produit'
      end
      product.input :total_weight, label: 'Poids total'
      product.inputs '', class: 'save-product' do
        product.action :submit, label: 'Sauvegarder', data: { id: 'submit-products' } do
          redirect_to root_path
        end
      end
    end
  end

  controller do
    def create
      @product = Product.new(permitted_params[:product])
      @product.label.reject!(&:empty?)
      if @product.save
        redirect_to admin_produits_path
      else
        @resource = @product
        render :new
      end
    end

    def update
      @product = Product.find(params[:id])
      @product.assign_attributes(permitted_params[:product])
      @product.label.reject!(&:empty?)
      if @product.save
        redirect_to admin_produits_path
      else
        @resource = @product
        render :edit
      end
    end

  end
end
