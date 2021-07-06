require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user1) { User.create(name: 'name_1', email: 'email_1@email.com', password: 'password_1') }
  let(:user2) { User.create(name: 'name_2', email: 'email_2@email.com', password: 'password_2') }
  let(:post1) { user1.posts.create(content: 'This is only an example') }

  describe 'Post can be liked by user' do
    it 'User should like any post already exits' do
      user1.likes.create(post_id: post1.id)

      expect(post1.likes.count).to eq(1)
    end

    it 'User can dislike if a post is already liked' do
      user1.likes.create(post_id: post1.id)
      like1 = Like.find_by(id: 1, user: user1, post_id: post1.id)
      like1.destroy

      expect(post1.likes.count).to eq(0)
    end

    it 'More than 1 users can like the same post' do
      user1.likes.create(post_id: post1.id)
      user2.likes.create(post_id: post1.id)

      expect(post1.likes.count).to eq(2)
    end
  end
end
