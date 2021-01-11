ActiveAdmin.register Farm do
  permit_params :name, :description, :photo, :address, :lagitude, :longitude, :opening_time, :labels, :country, :city, :iban, :zip_code, :farmer_number, :regions, :accepts_take_away

  form title: 'Exploitations' do |f|
    tabs do
      tab 'Etape 1' do
        panel 'Renseigner les informations de l’exploitations' do
          inputs 'Coordonnées' do
            input :name, label: false, placeholder: "Dénomination"
            input :address, label: false, placeholder: "Adresse"
            input :zip_code, label: false, placeholder: "CP"
            input :city, label: false, placeholder: "Ville"
            input :country, label: false, :as => :string, placeholder: "Pays"
          end
          inputs 'Informations légales' do
            input :farmer_number, label: false, placeholder: "Numéro exploitant"
          end
          inputs 'Informations bancaires' do
            input :iban, label: false, placeholder: "IBAN"
          end
        end
      end
      tab 'Advanced', html_options: { class: 'specific_css_class' } do
        f.inputs 'Advanced Details' do
          f.input :city
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
