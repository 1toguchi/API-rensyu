class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
    
    t.string :title, null: false
    t.text :detail
    t.binary :image
    
    t.timestamps null: false
    end
  end
end
