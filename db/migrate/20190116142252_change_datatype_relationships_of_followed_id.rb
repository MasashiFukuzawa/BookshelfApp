class ChangeDatatypeRelationshipsOfFollowedId < ActiveRecord::Migration[5.2]
  def change
    change_column :relationships, :followed_id, :integer
  end
end
