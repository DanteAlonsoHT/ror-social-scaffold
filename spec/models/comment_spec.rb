require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user1) { User.create(name: 'name_1', email: 'email_1@email.com', password: 'password_1') }
  let(:user2) { User.create(name: 'name_2', email: 'email_2@email.com', password: 'password_2') }
  let(:post1) { user1.posts.create(content: 'This is only an example') }
  let(:comment1) { Comment.create(content: 'This is only an example') }
  let(:comment2) { Comment.create(content: 'This is only an example') }

  describe 'Post can have a comment' do
    it 'User can create a comment inside post' do
      comment1.post_id = post1.id
      comment1.user = user1
      comment1.save

      expect(post1.comments.count).to eq(1)
    end

    it 'User can create one or more comments in the same post' do
      comment1.post_id = post1.id
      comment1.user = user2
      comment1.save

      comment2.post_id = post1.id
      comment2.user = user2
      comment2.save

      expect(post1.comments.count).to eq(2)
    end
  end
end
