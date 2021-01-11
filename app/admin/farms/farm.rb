ActiveAdmin.register Farm do
  form name: 'A custom title' do |f|
    inputs 'Details' do
      input :name
      input :address, label: "Publish Post At"
      input :opening_time
    end
    actions
  end

  permit_params :name, :description, :photo, :address, :lagitude, :longitude, :opening_time, :labels, :country, :city, :iban, :zip_code, :farmer_number, :regions, :accepts_take_away
end
