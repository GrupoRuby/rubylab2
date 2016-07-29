class CreateProductos < ActiveRecord::Migration
  def self.up
    create_table :productos do |t|
      t.string :nombre
      t.string :codigo
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :productos
  end
end
