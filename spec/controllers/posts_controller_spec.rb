require 'rails_helper'

describe PostsController do
  describe 'test for all user roles' do
    let(:admin_user) { FactoryGirl.build(:admin) }
    let(:normal_user) {  FactoryGirl.build(:gyorou) }
    let(:teacher_user)  { FactoryGirl.build(:teacher) }
    let(:post1)  { FactoryGirl.create(:post1) }
    let(:post1_params)  { FactoryGirl.attributes_for(:post1) }
    let(:post2_params)  { FactoryGirl.attributes_for(:post2) }

    context 'normal user can not go into post controller' do
      before do
        allow(controller).to receive(:current_user).and_return normal_user
      end
      it 'current_user is expected to be normal user' do
        expect(controller.current_user).to eq normal_user
      end
      it 'expected to not get access to index' do
        get :index
        expect(response.status).to eq 302
      end
      it 'expected to not get access to index' do
        get :show, id: post1
        expect(response.status).to eq 302
      end
      it 'expected to not able to create posts' do
        post :create, post: post2_params
        expect(assigns(:post)).to eq nil 
      end
      it 'expected to not be able to update posts' do
        patch :update, id: post1.id, post: post2_params
        expect(Post.find(post1.id).content).not_to eq post2_params[:content]
      end
      it 'expected to not be able to delete post' do
        expect(Post.all).to include post1
        delete :destroy, id: post1
        expect(Post.all).to include post1
      end
    end
    context 'teacher user can go into post controller' do
      before do
        allow(controller).to receive(:current_user).and_return teacher_user
      end
      it 'expected to get access to index' do
        get :index
        expect(response.status).to eq 200 
      end
      it 'expected to get access to post' do
        get :show, id: post1
        expect(assigns(:post)).to eq post1
      end
      it 'expected to be able to create posts' do
        post :create, post: post2_params
        expect(Post.last.content).to eq post2_params[:content]
      end
      it 'expected to be able to update posts' do
        patch :update, id: post1.id, post: post2_params
        expect(Post.find(post1.id).content).to eq post2_params[:content]
      end
      it 'expected to be able to delete post' do
        expect(Post.all).to include post1
        delete :destroy, id: post1
        expect(Post.all).not_to include post1
      end
    end

    context 'admin user can go into post controller' do
      before do
        FactoryGirl.reload
        allow(controller).to receive(:current_user).and_return admin_user
      end
      it 'expected to get access to index' do
        get :index
        expect(response.status).to eq 200 
      end
      it 'expected to get access to post' do
        get :show, id: post1
        expect(assigns(:post)).to eq post1
      end
      it 'expected to be able to create posts' do
        post :create, post: post2_params
        expect(Post.last.content).to eq post2_params[:content]
      end
      it 'expected to be able to update posts' do
        patch :update, id: post1.id, post: post2_params
        expect(Post.find(post1.id).content).to eq post2_params[:content]
      end
      it 'expected to be able to delete post' do
        expect(Post.all).to include post1
        delete :destroy, id: post1
        expect(Post.all).not_to include post1
      end
    end
  end
end
