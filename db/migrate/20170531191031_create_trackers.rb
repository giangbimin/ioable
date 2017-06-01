class CreateTrackers < ActiveRecord::Migration[5.0]
  def change
    create_table :trackers do |t|
      t.belongs_to :article, foreign_key: true
      t.string :guess_ip

      t.timestamps
    end
  end
end
