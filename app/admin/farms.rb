ActiveAdmin.register Farm, as: "Exploitations" do
  before_action :remove_password_params_if_blank, only: [:update]
  permit_params :active, :name, :description, :address, :lagitude, :longitude, :opening_time, :country, :city, :iban, :zip_code, :farmer_number, :regions, :accepts_take_away, :user_id, :long_description, :delivery_delay, :accept_delivery, photos: [], labels: [],
                opening_hours_attributes: [:id, :day, :opens, :closes],
                products_attributes: [:id, :active, :name, :available, :category_id, :photo, :description, :ingredients, :unit, :fresh, :price_per_unit_cents, :price_per_unit_currency, :price_cents, :price_currency, :subtitle, :minimum_weight, :display_minimum_weight, :conditioning, :preorder, :total_weight, label:[] ],
                categories_attributes: [:id, :name],
                category_ids: [],
                user_attributes: [:id, :email, :first_name, :last_name, :number_phone, :wants_to_subscribe_mailing_list, :photo, :password, :title, :password_confirmation, :address_line_1, :city, :zip_code, :farm_id]

  LABELS = ["Bio-Suisse", "IP-Suisse", "Suisse Garantie", "AOP", "IPG", "Naturabeef", "Demeter", "Bio-Suisse Reconversion"]

  index do
    bool_column :active
    column  "Nom", :name
    column "Propriétaire", :user do |col|
      col.user.first_name
    end
    column "Mail", :user do |col|
      col.user.email
    end
    column "Communes", :regions
    column "Délais préparation", :delivery_delay
    column :action do |resource|
      link_to "Editer", edit_admin_exploitation_path(resource)
    end
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
          # f.input :user, as: :search_select, url: search_for_users_path	, fields: [:first_name]
          f.input :user_id, as: :search_select, url: search_users_admin_path,
          fields: [:first_name, :last_name, :email, :number_phone], display_name: :full_name, minimum_input_length: 3,
          order_by: 'description_asc'
          # f.input :user, as: :select, collection: User.all {|category| [category.name, category.id] }
          inputs "Renseigner un propriétaire", for: [:user, params[:id] ? Farm.find(params[:id]).user : User.new] do |u|
            u.input :title, collection: User::TITLE, label: "Genre"
            u.input :first_name, label: false, placeholder: "Prénom"
            u.input :last_name, label: false, placeholder: "Nom"
            u.input :email, label: false, placeholder: "Mail"
            u.input :number_phone, label: false, placeholder: "Téléphone"
            u.input :address_line_1, label: false, placeholder: "Adresse"
            u.input :city, label: false, placeholder: "Ville"
            u.input :zip_code, label: false, placeholder: "Code postal"
            u.input :password, label: false, placeholder: "Mot de passe"
            u.input :password_confirmation, label: false, placeholder: "Confirmation du mot de passe"
            u.input :wants_to_subscribe_mailing_list, label: "L'inscrire a la newsletter"
            u.input :photo, as: :file, label: "Mettre une photo de profil"
          end
        end
      end
      tab 'Etape 2' do
        panel "Renseigner les informations de l'exploitation" do
          inputs 'Coordonnées' do
            input :name, label: false, placeholder: "Dénomination"
            input :address, label: false, placeholder: "Adresse"
            input :zip_code, label: false, placeholder: "CP", :wrapper_html => { :class => 'fl' }
            input :city, label: false, placeholder: "Ville", :wrapper_html => { :class => 'fl' }
            input :country, label: false, :as => :string, placeholder: "Pays", :wrapper_html => { :class => 'fl' }
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
          end
          inputs "Labels de l'exploitation" do
            input :labels, label: false, as: :check_boxes, collection: LABELS
          end
          inputs "Retrait a la ferme" do
            input :accepts_take_away, label: "Accepte le retrait à la ferme"
            f.has_many :opening_hours, heading: "", new_record: 'Ajouter une horaire' do |openning|
              openning.inputs do
                openning.input :day, label: "Jour", as: :select, collection: [["Lundi", 1], ["Mardi", 2], ["Mercredi", 3], ["Jeudi", 4], ["Vendredi", 5], ["Samedi", 6], ["Dimanche", 0]]
                openning.input :opens, label: "Ouverture"
                openning.input :closes, label: "Fermeture"
              end
            end
          end
          inputs 'Expéditions' do
            input :accept_delivery, label: "Accepte les expéditions"
          end
          inputs 'Délais de livraison' do
            input :delivery_delay, label: false
          end
          inputs 'Photos' do
            input :photos, as: :file, input_html: { multiple: true }, label: false
            input :photos, as: :file, input_html: { multiple: true }, label: false
            input :photos, as: :file, input_html: { multiple: true }, label: false
            input :photos, as: :file, input_html: { multiple: true }, label: false
            input :photos, as: :file, input_html: { multiple: true }, label: false
          end
        end
      end
      tab 'Etape 4' do
        panel 'Ajouter les catégorie' do
          f.input :category_ids, as: :check_boxes, collection: Category.all, label: false
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
              product.input :label, label: false, as: :check_boxes, collection: LABELS, label: "Label"
              product.input :preorder, label: "Date livraison précommande"
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
      if resource.persisted?
        f.action :submit, label: "Modifier l'exploitation"
      else
        f.action :submit, label: "Créer l'exploitation"
      end
    end
  end

  controller do
    def create
      @farm = Farm.new(permitted_params[:farm])
      @farm.user.skip_confirmation_notification!
      @farm.validate!
      @farm.products.each do |product|
        product.label.reject!(&:empty?)
      end

      @farm.labels.reject!(&:empty?)

      if @farm.save
        redirect_to admin_exploitations_path, notice: "Resource created successfully."
      else
        render :new
      end
    end

    def update
      @farm = Farm.find(params[:id])

      @farm.update!(permitted_params[:farm])
      @farm.labels.reject!(&:empty?)
      @farm.products.each do |product|
        product.label.reject!(&:empty?)
      end

      # @farm.assign_attributes(permitted_params[:farm])
      # if @farm.active
      #   unless @farm.save
      #     @farm.active = false
      #     @farm.save(validate: false)
      #     flash[:alert] = "Veuillez à compléter toutes les informations afin de rendre l'exploitation disponible."
      #   end
      # else
      #   @farm.save(validate: false)
      # end

      if @farm.save
        redirect_to admin_exploitations_path
      else
        render :edit
      end

    end

    def remove_password_params_if_blank
      if params[:farm][:user_attributes][:password].blank? && params[:farm][:user_attributes][:password_confirmation].blank?
        params[:farm][:user_attributes].delete(:password)
        params[:farm][:user_attributes].delete(:password_confirmation)
      end
    end
  end
end
