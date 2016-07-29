class CreateClientes < ActiveRecord::Migration
  def self.up
    create_table :clientes do |t|
      t.string :nombre
      t.string :apellido
      t.string :cedula
      t.string :correo
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :clientes
  end
end
