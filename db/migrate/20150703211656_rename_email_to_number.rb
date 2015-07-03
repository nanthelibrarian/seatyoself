class RenameEmailToNumber < ActiveRecord::Migration
  def change
    rename_column :restaurants, :email, :phone_number
  end
end
