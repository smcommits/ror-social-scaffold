class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  scope :accepted_requests, -> { sent_friend_requests.where('status = ?', :accepted) }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: :user_id
  has_many :recieved_friend_requests, class_name: 'FriendRequest', foreign_key: :friend_id

  def check_request_existence(friend)
    friends.include?(friend) or
      sent_friend_requests.where(friend_id: friend.id).exists? or
      recieved_friend_requests.where(user_id: friend.id).exists?
  end
end
