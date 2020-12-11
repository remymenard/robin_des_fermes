class AddWantsToSubscribeToNewsletterToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :wants_to_subscribe_mailing_list, :boolean
  end
end
