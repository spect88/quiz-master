class CreateQuizResults < ActiveRecord::Migration[5.0]
  def change
    create_table :quiz_results do |t|
      t.references :user, foreign_key: true, null: false
      t.references :quiz, foreign_key: true, null: false
      t.integer :score, null: false
      t.integer :max_score, null: false
      t.jsonb :details, null: false

      t.timestamps
    end
  end
end
