require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { User.create(name: 'name_1', email: 'email_1@email.com', password: 'password_1') }
  let(:user2) { User.create(name: 'name_2', email: 'email_2@email.com', password: 'password_2') }
  let(:not_valid_user) { User.create(name: nil, email: nil, password: 'password_3') }
  let(:not_valid_user2) { User.create(name: 'name_3', email: nil, password: 'password_4') }

  describe 'User is created' do
    it 'Valid if all mandatory fields have been filled' do
      expect(user1).to be_valid
    end

    it 'Invalid if all mandatory fields have not been filled' do
      expect(not_valid_user).to_not be_valid
    end

    it 'Invalid if all mandatory fields have not been filled' do
      expect(not_valid_user2).to_not be_valid
    end
  end

  describe 'User can request a friendship' do
    it 'User can send invitation to be friend' do
      new_friend = user1.friendships.new(friend_id: user2.id)
      new_friend.save

      expect(user1.pending_friends.count).to eq(1)
    end
  end
end
