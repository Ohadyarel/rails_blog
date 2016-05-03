class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :blog_title
      t.string :blog_cat
      t.string :password

      t.timestamps null: false
    end
  end
end
