require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @tweet = FactoryBot.create(:tweet)
    @comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーはツイート詳細ページでコメント投稿できる' do
    # ログインする
    # ツイート詳細ページに遷移する
    # フォームに情報を入力する
    # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
    # 詳細ページにリダイレクトされることを確認する
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
  end
end