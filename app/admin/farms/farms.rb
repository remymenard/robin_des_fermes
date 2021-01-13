ActiveAdmin.register Farm, as: "Exploitations" do
  permit_params :name, :description, :address, :lagitude, :longitude, :opening_time, :labels, :country, :city, :iban, :zip_code, :farmer_number, :regions, :accepts_take_away, :user_id, :long_description, :delivery_delay, :accept_delivery, photos: [],
                opening_hours_attributes: [:id, :day, :opens, :closes],
                user_attributes: [:id, :email, :first_name, :last_name, :number_phone, :wants_to_subscribe_mailing_list, :photo, :password, :title, :password_confirmation, :address_line_1, :city, :zip_code]
  LABELS = ["Bio-Suisse", "IP-Suisse", "Suisse Garantie", "AOP", "IPG", "Naturabeef", "Demeter", "Bio-Suisse Reconversion"]

  form title: 'Exploitations' do |f|
    tabs do
      tab 'Etape 1' do
        panel 'Déclarer un Propriétaire' do
          f.inputs "Renseigner un propriétaire" do
            f.has_many :user, class_name: 'Abcd::User' do |u|
              u.input :title, collection: User::TITLE
              u.input :first_name
              u.input :last_name
              u.input :email
              u.input :number_phone
              u.input :address_line_1
              u.input :city
              u.input :zip_code
              u.input :password
              u.input :password_confirmation
              u.input :wants_to_subscribe_mailing_list
              u.input :admin
              u.input :photo, as: :file
            end
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
      @opening_hour = OpeningHour.new(permitted_params[:opening_hours])
      @opening_hour.save
      @user = User.new(permitted_params[:user])
      @user.save
      @farm = Farm.new(permitted_params[:farm])
      @farm.save!
      create! { |success, failure|
        success.html do
          redirect_to admin_exploitations_path, :notice => "Resource created successfully."
        end
        failure.html do
          render 'new'
        end
      }
    end

    def update
      @farm = Farm.find(params[:id])
      @farm.update(permitted_params[:farm])
      redirect_to admin_exploitations_path
    end
  end
end
