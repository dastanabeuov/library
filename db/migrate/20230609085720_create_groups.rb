class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name, null: false, default: ""
      t.string :type, null: false, default: ""
      t.string :code, null: false, default: ""
      t.string :email, null: false, default: ""
      t.string :phone, null: false, default: ""
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
