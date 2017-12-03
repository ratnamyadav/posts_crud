require 'rails_helper'

describe PostsController do

  describe 'GET #index' do
    it 'populates an array of posts' do
      post = create(:post)

      get :index

      result = JSON.parse(response.body)
      expect(result.length).to eq(1)
      expect(result[0]['title']).to eql(post.title)
    end
  end

  describe 'GET #create' do
    it 'creates a post' do
      params_obj = { title: Faker::Company.bs, description: Faker::ChuckNorris.fact, created_by: Faker::Name }

      post :create, params: { post: params_obj }

      expect(response.status).to eq(201)
    end

    it 'raises an error on empty title' do
      params_obj = { title: nil, description: Faker::ChuckNorris.fact, created_by: Faker::Name }

      post :create, params: { post: params_obj }

      expect(response.status).to eq(422)
    end

    it 'raises an error on empty Description' do
      params_obj = { title: Faker::Company.bs, description: nil, created_by: Faker::Name }

      post :create, params: { post: params_obj }

      expect(response.status).to eq(422)
    end

    it 'raises an error on empty created by' do
      params_obj = { title: Faker::Company.bs, description: Faker::ChuckNorris.fact, created_by: nil }

      post :create, params: { post: params_obj }

      expect(response.status).to eq(422)
    end
  end


  describe 'GET #update' do
    it 'successfully updates a post' do
      post = create(:post)
      params_obj = { title: Faker::Company.bs, description: Faker::ChuckNorris.fact }

      patch :update, params: { id: post.id, post: params_obj }

      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result['title']).to eq(params_obj[:title])
      expect(result['description']).to eq(params_obj[:description])
      expect(result['created_by']).to eq(post.created_by)
    end

    it 'unsuccessful update when params are empty for required fields' do
      post = create(:post)
      params_obj = { title: nil, description: Faker::ChuckNorris.fact }

      patch :update, params: { id: post.id, post: params_obj }

      after_post = Post.find(post.id)
      expect(response.status).to eq(422)
      expect(after_post.title).to eq(post.title)
      expect(after_post.description).to eq(post.description)
      expect(after_post.created_by).to eq(post.created_by)
    end
  end

  describe 'GET #destroy' do
    it 'successfully deletes a post' do
      post = create(:post)

      delete :destroy, params: { id: post.id }

      expect(response.status).to eq(204)
      expect(Post.count).to eq(0)
    end
  end
end