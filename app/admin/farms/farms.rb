ActiveAdmin.register Farm, as: "Exploitations" do
  permit_params :name, :description, :address, :lagitude, :longitude, :opening_time, :country, :city, :iban, :zip_code, :farmer_number, :regions, :accepts_take_away, :user_id, :long_description, :delivery_delay, :accept_delivery, labels: [], photos: [],
                opening_hours_attributes: [:id, :day, :opens, :closes],
                products_attributes: [:id, :name, :category_id],
                user_attributes: [:id, :email, :first_name, :last_name, :number_phone, :wants_to_subscribe_mailing_list, :photo, :password, :title, :password_confirmation, :address_line_1, :city, :zip_code, :farm_id]
  LABELS = ["Bio-Suisse", "IP-Suisse", "Suisse Garantie", "AOP", "IPG", "Naturabeef", "Demeter", "Bio-Suisse Reconversion"]

  form title: 'Exploitations' do |f|
    tabs do
      tab 'Etape 1' do
        panel 'Déclarer un Propriétaire' do
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
        panel 'Créer un produit' do
          f.has_many :products, heading: "", new_record: 'Ajouter un produit' do |product|
            product.inputs do
              product.input :name
              product.input :category_id, as: :select, collection: Category.all
            end
          end
        end
      end
    end
    f.actions do
      if resource.persisted?
        f.action :submit, as: :button, label: "Modifier l'exploitation"
      else
        f.action :submit, as: :button, label: "Créer l'exploitation"
      end
    end
  end

  controller do
    def create
      @farm = Farm.new(permitted_params[:farm])
      @farm.save!

      @opening_hour = OpeningHour.new(permitted_params[:opening_hours])
      @opening_hour.farm = @farm
      @opening_hour.save

      @product = Product.new(permitted_params[:products])
      @product.farm = @farm
      @product.save

      @user = User.new(permitted_params[:user])
      @user.valid = true
      @user.save

      create! do |success, failure|
        success.html do
          redirect_to admin_exploitations_path, :notice => "Resource created successfully."
        end

        failure.html do
          render 'new'
        end
      end
    end

    def update
      @farm = Farm.find(params[:id])
      #@user = User.find(@farm.user_id)
      @farm.update(permitted_params[:farm])
      redirect_to admin_exploitations_path
    end

    def update_resource(object, attributes)
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end
  end
end
