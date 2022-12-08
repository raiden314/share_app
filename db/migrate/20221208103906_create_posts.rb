class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :url
      t.string :title
      t.string :summary
      t.string :keyword

      t.timestamps
    end
  end
end
