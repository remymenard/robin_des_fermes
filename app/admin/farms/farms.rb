ActiveAdmin.register Farm do
  permit_params :name, :description, :photo, :address, :lagitude, :longitude, :opening_time, :labels, :country, :city, :iban, :zip_code, :farmer_number, :regions, :accepts_take_away, :user_id
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
      tab 'Etape 2', html_options: { class: 'specific_css_class' } do
        panel 'Créer la boutique' do
          inputs 'Description courte' do
            input :description, label: false
          end
          inputs 'Description longue' do
            input :long_description, label: false
          end
          inputs "Labels de l'exploitation" do
            input :labels,  label: false, as: :check_boxes, collection: LABELS
          end
        end
      end
    end
    actions
  end

  controller do
    def create
      @farm = Farm.new(permitted_params[:farm])
      @farm.save
    end
  end
end
