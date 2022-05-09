class AddCompanionToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column    :users, :companion_starting_date, :date
    add_column    :users, :companion_ending_date, :date
  end
end
