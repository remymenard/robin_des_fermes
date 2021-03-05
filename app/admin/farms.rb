ActiveAdmin.register Farm, as: "Exploitations" do

  before_action :remove_password_params_if_blank, only: [:update]

  permit_params :active, :name, :description, :address, :lagitude, :longitude, :photo_portrait, :opening_time, :country, :city, :iban, :zip_code, :farmer_number, :accepts_take_away, :user_id, :long_description, :delivery_delay, :accepts_delivery, photos: [], labels: [], offices: [], regions: [],
                opening_hours_attributes: [:id, :day, :opens, :closes],
                products_attributes: [:id, :active, :available_for_preorder, :name, :available, :category_id, :photo, :description, :ingredients, :unit, :fresh, :price_per_unit_cents, :price_per_unit_currency, :price_cents, :price_currency, :subtitle, :minimum_weight, :display_minimum_weight, :conditioning, :preorder_shipping_starting_at, :total_weight, label:[] ],
                categories_attributes: [:id, :name],
                category_ids: [],
                user_attributes: [:id, :email, :first_name, :last_name, :number_phone, :wants_to_subscribe_mailing_list, :photo, :password, :title, :password_confirmation, :address_line_1, :city, :zip_code, :farm_id]

  actions :all

  index do
    actions defaults: true
    column :active
    column  "Nom", :name
    column "Propriétaire", :user do |col|
      col.user.first_name
    end
    column "Mail", :user do |col|
      col.user.email
    end
    column "Communes", :regions
    column "Délais préparation", :delivery_delay
  end

  filter :active, as: :boolean, label: "Active ?"
  filter :name, label: "Nom de l'exploitation"
  filter :user, label: "Propriétaire"
  filter :categories, label: "Catégories"
  filter :updated_at, label: "Dernière modification"


  form title: 'Exploitations' do |f|
    tabs do
      tab 'Etape 1' do
        panel 'Activer la ferme'do
          input :active, label: " Disponible ?"
        end
        panel 'Déclarer un Propriétaire' do
          f.input :user_id, as: :search_select, id: "select-user", url: search_users_admin_path,
          fields: [:first_name, :last_name, :email, :number_phone], display_name: :full_name, minimum_input_length: 3,
          order_by: 'description_asc', label: 'Chercher un propriétaire existant', clearable: false
          inputs "Informations du propriétaire", class: "owner-form", for: [:user, params[:id] ? Farm.friendly.find(params[:id]).user : User.new] do |u|
            u.input :title,                           label: "Genre",         collection: User::TITLE
            u.input :first_name,                      label: false,           placeholder: "Prénom"
            u.input :last_name,                       label: false,           placeholder: "Nom"
            u.input :email,                           label: false,           placeholder: "Mail"
            u.input :number_phone,                    label: false,           placeholder: "Téléphone"
            u.input :address_line_1,                  label: false,           placeholder: "Adresse"
            u.input :city,                            label: false,           placeholder: "Ville"
            u.input :zip_code,                        label: false,           placeholder: "Code postal"
            u.input :password,                        label: false,           placeholder: "Mot de passe"
            u.input :password_confirmation,           label: false,           placeholder: "Confirmation du mot de passe"
            u.input :wants_to_subscribe_mailing_list, label: "L'inscrire a la newsletter"
            u.input :photo, as: :file,                label: "Mettre une photo de profil"
          end
        end
      end
      tab 'Etape 2' do
        panel "Renseigner les informations de l'exploitation" do
          inputs 'Coordonnées' do
            input :name,     label: false, placeholder: "Dénomination"
            input :address,  label: false, placeholder: "Adresse"
            input :zip_code, label: false, placeholder: "CP",                wrapper_html: { :class => 'fl' }
            input :city,     label: false, placeholder: "Ville",             wrapper_html: { :class => 'fl' }
            input :country,  label: false, placeholder: "Pays", as: :string, wrapper_html: { :class => 'fl' }
          end
          inputs 'Informations légales' do
            input :farmer_number, label: false, placeholder: "Numéro exploitant"
          end
          inputs 'Informations bancaires' do
            input :iban, label: false, placeholder: "IBAN"
          end
        end
      end
      tab 'Etape 3' do
        panel 'Créer la boutique' do
          inputs 'Description courte' do
            input :description, label: false
          end
          inputs 'Description longue' do
            input :long_description, label: false
            input :photo_portrait, as: :file, label: "format portrait"
          end
          inputs "Labels de l'exploitation" do
            input :labels, label: false, as: :check_boxes, collection: Farm::LABELS
          end
          inputs "Retrait a la ferme" do
            input :accepts_take_away, label: "Accepte le retrait à la ferme"
            f.has_many :opening_hours, heading: "", new_record: 'Ajouter une horaire' do |opening|

              opening.inputs do
                days = [["Lundi", 1], ["Mardi", 2], ["Mercredi", 3], ["Jeudi", 4], ["Vendredi", 5], ["Samedi", 6], ["Dimanche", 0]]

                opening.input :day,    label: "Jour", as: :select, collection: days
                opening.input :opens,  label: "Ouverture"
                opening.input :closes, label: "Fermeture"
              end
            end
          end

          inputs 'Expéditions' do
            input :accepts_delivery, label: "Accepte les expéditions"
          end

          inputs 'Délais de livraison' do
            input :delivery_delay, label: false
          end

          inputs "Horaires d'ouverture" do
            input :opening_time, label: false
          end

          inputs 'Offices de livraison' do
            input :offices, label: false, as: :check_boxes, collection: Farm::OFFICES.keys
          end

          inputs 'Photos' do
            input :photos, as: :file, input_html: { multiple: true }, label: "format paysage"
            input :photos, as: :file, input_html: { multiple: true }, label: "format paysage"
            input :photos, as: :file, input_html: { multiple: true }, label: "format paysage"
            input :photos, as: :file, input_html: { multiple: true }, label: "format paysage"
            input :photos, as: :file, input_html: { multiple: true }, label: "format paysage"
          end
        end
      end
      tab 'Etape 4' do
        panel 'Ajouter les catégorie' do
          f.input :category_ids, as: :check_boxes, collection: Category.all, label: false
        end
        panel "Produit(s) existant(s)" do
          table_for resource.products do
            column "Nom du produit", :name
            column "Catégorie du produit", :category, sortable: true
            column "Prix (CHF)", :price, sortable: true
            column "Actif", :active
            column do |produit|
              link_to 'Modifier', edit_admin_produit_path(produit), data: {confirm: 'Les modifications effectuées non sauvegardées seront perdues. Etes vous sûr de continuer ?'}
            end
          end
        end
        panel 'Créer un produit' do
          f.has_many :products, heading: "", new_record: 'Ajouter un produit' do |product|
            product.inputs do
              product.input :available, label: "Disponible ?"
              product.input :name, label: "Nom"
              product.input :category_id, as: :select, collection: Category.all, label: "Catégorie"
              product.input :price_cents, label: "Prix CHF"
              product.input :display_minimum_weight, label: "Afficher poids Minimum ?"
              product.input :minimum_weight, label: "Poids ou volume"
              product.input :unit, label: "Unité"
              product.input :price_per_unit_cents, label: "Prix au kg"
              product.input :conditioning, label: "Conditionnement"
              product.input :fresh, label: "Frais"
              product.input :label, label: false, as: :check_boxes, collection: Farm::LABELS, label: "Label"
              product.input :available_for_preorder, label: "Disponible en précommande"
              product.input :preorder_shipping_starting_at, label: "Date livraison précommande"
              product.input :description, label: "Description"
              product.input :ingredients, label: "Ingrédients"
              product.input :photo, as: :file, label: "Image du produit"
              product.input :total_weight, label: "Poids total"
            end
          end
        end
      end
    end
    f.actions do
      f.action :submit, label: "Valider l'exploitation"

    end
  end

  controller do
    defaults :finder => :find_by_slug
    def create
      @farm = Farm.new(permitted_params[:farm])
      @farm.user.skip_confirmation_notification!

      @farm.products.each do |product|
        product.label.reject!(&:empty?)
      end

      @farm.labels.reject!(&:empty?)

      if @farm.save
        redirect_to admin_exploitations_path, notice: "Resource created successfully."
      else
        @resource = @farm
        render :new
      end
    end

    def update
      @farm = Farm.friendly.find(params[:id])
      params[:farm].delete(:user_id) if params[:farm][:user_id] == ""

      @farm.update!(permitted_params[:farm])
      @farm.labels.reject!(&:empty?)

      @farm.products.each do |product|
        product.label.reject!(&:empty?)
      end

      if @farm.save
        redirect_to admin_exploitations_path
      else
        @resource = @farm
        render :edit
      end

    end


    def remove_password_params_if_blank
      unless params[:farm][:user_attributes].nil?
        if params[:farm][:user_attributes][:password].blank? && params[:farm][:user_attributes][:password_confirmation].blank?
          params[:farm][:user_attributes].delete(:password)
          params[:farm][:user_attributes].delete(:password_confirmation)
        end
      end
    end

  end
end
