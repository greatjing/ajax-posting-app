class Post < ApplicationRecord
  validates_presence_of :content
  belongs_to :user
  # optional表示可选非必选
  belongs_to :category, :optional => true
  # 有许多的打分，用class_name更换了名字
  has_many :scores, :class_name => "PostScore"

  has_many :likes, :dependent => :destroy
  has_many :liked_users, :through => :likes, :source => :user

  def find_like(user)
    self.likes.where( :user_id => user.id , :status => "like" ).first
  end

  def find_collect(user)
    self.likes.where( :user_id => user.id , :status => "collect" ).first
  end

# 找到某一user的打分
  def find_socre(user)
    user && self.scores.where( :user_id => user.id ).first
  end
# post的平均打分
  def average_score
    self.scores.average(:score)
  end

end
