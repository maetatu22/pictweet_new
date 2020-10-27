require 'rails_helper'
describe TweetsController, type: :request do
  
  before do
    @tweet = FactoryBot.create(:tweet)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do 
    end
    it "indexアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する" do 
    end
    it "indexアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する" do 
    end
    it "indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する" do 
    end
  end
end