require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user1) { User.create(name: 'name_1', email: 'email_1@email.com', password: 'password_1') }
  let(:user2) { User.create(name: 'name_2', email: 'email_2@email.com', password: 'password_2') }
  let(:post1) { user1.posts.create(content: 'This is only an example') }
  let(:comment1) { Comment.create(content: 'This is only an example') }
  let(:comment2) { Comment.create(content: 'This is only an example') }
  let(:comment3) { Comment.create(content: nil) }

  describe 'Comment can be valid if content is not nil' do
    it 'Valid is expected when content is not nil' do
      comment1.post_id = post1.id
      comment1.user = user1
      comment1.save
      expect(comment1).to be_valid
    end
  end

  describe 'Comment can be invalid if content is nil' do
    it 'Not valid is expected when content is nil' do
      comment3.post_id = post1.id
      comment3.user = user1
      comment3.save
      expect(comment3.invalid?).to eq(true)
    end
  end

  describe 'Post can have a comment' do
    it 'User can create a comment inside post' do
      comment1.post_id = post1.id
      comment1.user = user1
      comment1.save

      expect(post1.comments.count).to eq(1)
    end
  end

  describe 'Post can have more than 1 comment' do
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
