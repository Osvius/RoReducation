class AddEmailConfirmToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :verified, :boolean, default: false
    add_column :users, :verify_token, :string
  end
end
