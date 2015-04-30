class CreateQuestionnaires < ActiveRecord::Migration
  def change
    create_table :questionnaires do |t|
      t.references :startup
      t.string :email
      t.text :a1
      t.integer :a2
      t.integer :a3
      t.integer :a4
      t.integer :a5
      t.text :opinion
      t.string :code

      t.timestamps
    end
  end
end
