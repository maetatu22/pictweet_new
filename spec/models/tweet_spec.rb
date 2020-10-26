
RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
  end

  describe 'ツイートの保存' do
    context "ツイートが保存できる場合" do
      it "画像とテキストがあればツイートは保存される" do
      end
      it "テキストのみあればツイートは保存される" do
      end
    end
    context "ツイートが保存できない場合" do
      it "テキストがないとツイートは保存できない" do
      end     
      it "ユーザーが紐付いていないとツイートは保存できない" do
      end
    end
  end
end