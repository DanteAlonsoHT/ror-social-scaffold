require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user1) { User.create(name: 'name_1', email: 'email_1@email.com', password: 'password_1') }
  let(:post1) { user1.posts.create(content: 'This is only an example') }

  describe 'Post can be created' do
    it 'An user can create a post' do
      expect(post1).to be_valid
    end
  end
end
