class ChangeDatatypeRelationshipsOfFollowerId < ActiveRecord::Migration[5.2]
  def change
    change_column :relationships, :follower_id, :'integer USING CAST(follower_id AS integer)'
  end
end
