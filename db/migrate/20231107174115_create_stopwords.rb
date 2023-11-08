class CreateStopwords < ActiveRecord::Migration[7.1]
  def change
    create_table :stopwords do |t|
      t.string :word

      t.timestamps
    end
  end
end
