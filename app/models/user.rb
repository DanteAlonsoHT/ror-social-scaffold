class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: "Friendship"
  has_many :friends, through: :confirmed_friendships

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array += inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship unless friendship.confirmed }.compact
  end

  def pending_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def pending_friendship(user)
    friend_requests.find { |friendship| friendship if friendship.user == user }
  end

  def pending_friendship?(user)
    !pending_friendship(user).nil?
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |current_friendship| current_friendship.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def reject_friend(user)
    friendship = inverse_friendships.find { |friend| friend.user == user }
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end
end
