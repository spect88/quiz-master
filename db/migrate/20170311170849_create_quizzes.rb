class CreateQuizzes < ActiveRecord::Migration[5.0]
  def change
    create_table :quizzes do |t|
      t.string :title, limit: 256, null: false
      t.text :description, null: false
      t.jsonb :content, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
