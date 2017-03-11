class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.string :provider, null: false
      t.jsonb :info, null: false

      t.timestamps
    end

    add_index :users, [:uid, :provider], unique: true
  end
end
