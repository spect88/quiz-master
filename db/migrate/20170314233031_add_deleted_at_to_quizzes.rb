class AddDeletedAtToQuizzes < ActiveRecord::Migration[5.0]
  def change
    add_column :quizzes, :deleted_at, :boolean
  end
end
