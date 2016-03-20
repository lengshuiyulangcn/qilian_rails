require 'rails_helper'
 
RSpec.describe Post, :type => :model do

  describe 'model exists' do
    post = FactoryGirl.create(:post1)
    it{ expect(post.title).to eq 'test post 1'  }
  end
end
