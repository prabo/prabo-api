class CreateCompletes < ActiveRecord::Migration[5.0]
  def change
    create_table :completes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :mission, index: true, foreign_key: true

      t.timestamps
    end

    add_index :completes, [:user_id, :mission_id], :unique => true
  end
end
