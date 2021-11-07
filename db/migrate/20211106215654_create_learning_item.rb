class CreateLearningItem < ActiveRecord::Migration[6.0]
  def change
    create_table :learning_items do |t|
      t.string :title
      t.string :confusing_part # what confuses/confused you about this?
      t.boolean :is_learned
      t.text :documentation
      t.references :user
      
      t.timestamps
    end
  end
end
