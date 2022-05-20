ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Exploitations modifiées récemments" do
          table_for Farm.order(:updated_at).take(10) do
            column "Nom", :name
            column do |produit|
              link_to 'Modifier', edit_admin_exploitation_path(produit)
            end
          end
        end
        end
      end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content


end
