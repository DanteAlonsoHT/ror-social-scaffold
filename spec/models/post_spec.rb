require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user1) { User.create(name: 'name_1', email: 'email_1@email.com', password: 'password_1') }
  let(:post1) { user1.posts.create(content: 'This is only an example') }

  describe 'Post can be valid' do
    it 'A post is valid when it has requirements enough' do
      expect(post1).to be_valid
    end
  end

  describe 'Post can be create and being part from user' do
    it '1 is expected if user only create 1 post' do
      post1
      expect(Post.where(user_id: user1.id).count).to eq(1)
    end
  end

  describe 'Post can be created by user if it has nil content' do
    it '0 is expected if user try to create a post with nil content' do
      user1.posts.create(content: nil)

      expect(Post.where(user_id: user1.id).count).to eq(0)
    end
  end
end
