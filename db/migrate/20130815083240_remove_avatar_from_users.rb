class RemoveAvatarFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, "avatar_file_name"
    remove_column :users, "avatar_content_type"
    remove_column :users, "avatar_file_size"
    add_attachment :users, :avatar
  end

  def down
  end
end
