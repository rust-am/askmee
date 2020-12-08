class AddIndexToEmailAndUsername < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.index :email, unique: true
      t.index :username, unique: true
    end
  end
end
