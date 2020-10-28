require 'rails_helper'

RSpec.describe 'ツイート投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet_text = Faker::Lorem.sentence
    @tweet_image = Faker::Lorem.sentence
  end
  context 'ツイート投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password 
      find('input[name="commi"]').click
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_conten("新規登録")
      # 投稿ページに移動する
      visit new_tweet_path
      # フォームに情報を入力する
      fill_in 'tweet_image', with: @tweet_image
      fill_in 'tweet_text', with: @tweet_text
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change {Tweet.count}.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(current_path).to wq tweet_path
      # 「投稿が完了しました」の文字があることを確認する
      expect(page).to have_content("投稿が完了しました")
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector ".content_post[style='bacground-image: url(#{@tweet_image});']"
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
      ecpect(page).to have_content(@tweet_text)
    end
  end
  context 'ツイート投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content("投稿する")
    end
  end
end

RSpec.describe 'ツイート編集', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context 'ツイート編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in "Email", with: @tweet1.user.email
      fill_in "Password", with: @tweet1.user.password 
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ツイート1に「編集」ボタンがあることを確認する
      expect(
        all(".more")[1].hover
      ).to have_link '編集', href: edit_tweet_path(@tweet1.id)
      # 編集ページへ遷移する
      visit edit_tweet_path(@tweet1.id)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#tweet_image').value
      ).to eq @tweet1.image
      expect(
        find('#tweet_text').value
      ).to eq @tweet1.text
      # 投稿内容を編集する
      fill_in 'tweet_image', with: "#{@tweet1.image}+編集した画像URL"
      fill_in 'tweet_text', with: "#{@tweet1.text}+編集したテキスト"
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change {Tweet.count}.by(0)
      # 編集完了画面に遷移したことを確認する
      expect(current_path).to eq tweet_path(@tweet1)
      # 「更新が完了しました」の文字があることを確認する
      expect(page).to have_content("更新が完了しました")
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector ".content_post[style='background-image: url(#{@tweet1.image}+編集した画像URL);']"
      # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content("#{@tweet1.text}+編集したテキスト")
    end
  end
  context 'ツイート編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @tweet1.user.email
      fill_in 'Password', with: @tweet1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ツイート2に「編集」ボタンがないことを確認する
      expect(
        all(".more")[0].hover
      ).to have_no_link '編集' ,href: edit_tweet_path(@tweet2.id)
    end
    it'ログインしていないとツイートの編集画面には遷移できない'  do
      # トップページにいる
      visit root_path
      # ツイート1に「編集」ボタンがないことを確認する
      expect(
        all(".more")[1].hover
      ).to have_no_link '編集' ,href: edit_tweet_path(@tweet1.id)
      # ツイート2に「編集」ボタンがないことを確認する
      expect(
        all(".more")[0].hover
      ).to have_no_link '編集', href: edit_tweet_path(@tweet2.id)
    end
  end
end