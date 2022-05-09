ActiveAdmin.register User, as: "Utilisateurs" do
  before_action :remove_password_params_if_blank, only: [:update]

  permit_params :id, :admin, :email, :first_name, :last_name, :number_phone, :wants_to_subscribe_mailing_list, :photo, :password, :title,
  :password_confirmation, :address_line_1, :city, :zip_code, :farm_id, :companion_starting_date, :companion_ending_date

  form title: 'Utilisateurs' do |f|
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
      input :companion_starting_date, as: :date_time_picker,
      picker_options: {
        timepicker: false,
        format: 'Y-m-d'
      }
      input :companion_ending_date, as: :date_time_picker,
      picker_options: {
        timepicker: false,
        format: 'Y-m-d'
      }
      input :admin, label: "Admin"
      if f.object.photo.attached?
        input :photo, as: :file, label: "Changer la photo de profil", hint: image_tag(cl_image_path(f.object.photo.key), height: 256)
      else
        input :photo, as: :file, label: "Mettre une photo de profil"
      end
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
          redirect_to admin_exploitations_path, notice: "Resource created successfully."
        end

        failure.html do
          render 'new'
        end
      end
    end

    def update
      @user = User.find(params[:id])
      @user.update!(permitted_params[:user])

      if @user.save
        redirect_to admin_utilisateurs_path
      else
        render :edit
      end
    end

    def remove_password_params_if_blank
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
    end
  end
end
