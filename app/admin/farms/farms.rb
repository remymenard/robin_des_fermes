ActiveAdmin.register Farm, as: "Exploitations" do
  permit_params :name, :description, :photos, :address, :lagitude, :longitude, :opening_time, :labels, :country, :city, :iban, :zip_code, :farmer_number, :regions, :accepts_take_away, :user_id, :long_description, :delivery_delay, :accept_delivery
  LABELS = ["Bio-Suisse", "IP-Suisse", "Suisse Garantie", "AOP", "IPG", "Naturabeef", "Demeter", "Bio-Suisse Reconversion"]

  form title: 'Exploitations' do |f|
    tabs do
      tab 'Etape 1' do
        panel 'Renseigner les informations de l’exploitations' do
          inputs 'Coordonnées' do
            input :user_id, label: false, placeholder: "user_id"
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
      tab 'Etape 2' do
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
          end
        end
      end
    end
    f.actions do
      f.action :submit, as: :button, label: 'Créer une exploitation'
    end
  end

  controller do
    def create
      @farm = Farm.new(permitted_params[:farm])
      @farm.save

      redirect_to admin_exploitations_path
    end
  end
end
