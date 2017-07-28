class Post < ApplicationRecord
  validates_presence_of :content
  belongs_to :user
  # optional表示可选非必选
  belongs_to :category, :optional => true

  has_many :likes, :dependent => :destroy
  has_many :liked_users, :through => :likes, :source => :user

  def find_like(user)
    self.likes.where( :user_id => user.id , :status => "like" ).first
  end

  def find_collect(user)
    self.likes.where( :user_id => user.id , :status => "collect" ).first
  end

end
