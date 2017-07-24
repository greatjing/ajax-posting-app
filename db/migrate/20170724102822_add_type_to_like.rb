class AddTypeToLike < ActiveRecord::Migration[5.0]
  def change
    add_column :likes, :status, :string,  default: "like"
  end
end
