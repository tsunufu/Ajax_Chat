class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :user_name
      t.text :body
      t.timestamps null: false
    end
  end
end
