class Mission < ActiveRecord::Migration[5.0]
  def change
    create_table :missions do |t|
      t.string :title,       null: false, default: ""
      t.string :description, null: false, default: ""
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end

    add_index :missions, :title
    add_index :missions, :description
  end
end
