ActiveAdmin.register User, as: "Utilisateurs" do
  permit_params :id, :email, :first_name, :last_name, :number_phone, :wants_to_subscribe_mailing_list, :photo, :password, :title, :password_confirmation, :address_line_1, :city, :zip_code, :farm_id

  form title: 'A custom title' do |f|
    inputs "Renseigner un propriétaire" do
      input :title, collection: User::TITLE, label: "Genre"
      input :first_name, label: false, placeholder: "Prénom"
      input :last_name, label: false, placeholder: "Nom"
      input :email, label: false, placeholder: "Mail"
      input :number_phone, label: false, placeholder: "Téléphone"
      input :address_line_1, label: false, placeholder: "Adresse"
      input :city, label: false, placeholder: "Ville"
      input :zip_code, label: false, placeholder: "Code postal"
      input :password, label: false, placeholder: "Mot de passe"
      input :password_confirmation, label: false, placeholder: "Confirmation du mot de passe"
      input :wants_to_subscribe_mailing_list, label: "L'inscrire a la newsletter"
      input :photo, as: :file, label: "Mettre une photo de profil"
    end
    f.actions do
      if resource.persisted?
        f.action :submit, as: :button, label: "Modifier le propriétaire"
      else
        f.action :submit, as: :button, label: "Créer le propriétaire"
      end
    end
  end

  controller do
    def create

      @user = User.new(permitted_params[:user])
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
      @user = User.find(params[:id])
      @user.update(permitted_params[:user])

      update! do |success, failure|
        success.html do
          redirect_to admin_utilisateurs_path
        end
      end
    end
  end
end
