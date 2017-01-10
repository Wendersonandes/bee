class AddUserIdToPrinters < ActiveRecord::Migration
  def change
    add_reference :printers, :user, index: true
    add_foreign_key :printers, :users
  end
end
