require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "新規登録/ユーザー情報" do
    context "新規登録できるとき" do
    it "passwordとpassword_confirmation,first_name,last_name,（全角・ひらがな・カタカナ）,kana_first_name,kana_last_name（全角のカタカナ入力であること）
        生年月日が記入できていれば登録できる" do
        expect(@user).to be_valid
    end
  end

  context "新規登録できない時" do
  it "nicknameが空では登録できない" do
    @user.nickname = ""
    @user.valid?
    expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
  end

  it "emailが空では登録できない" do
    @user.email = ""
    @user.valid?
    expect(@user.errors.full_messages).to include("Email can't be blank")
  end

  it "emailに@が含まれていなければ登録できない" do
    @user.email = "abcd1234"
    @user.valid?
    expect(@user.errors.full_messages).to include("Email is invalid")
  end

  it "重複したemailがあると登録できない" do
    first_user = FactoryBot.create(:user, email: "123@456")
    another_user = FactoryBot.build(:user, email: first_user.email)
    another_user.valid?
    expect(another_user.errors.full_messages).to include("Email has already been taken")
  end

  # 上記の記述を短縮前の形
  # it "重複したemailがあると登録できない" do
  #   first_user = FactoryBot.build(:user)
  #   first_user.email = "123@456"
  #   first_user.save
  #   another_user = FactoryBot.build(:user)
  #   another_user.email = first_user.email
  #   another_user.valid?
  #   expect(another_user.errors.full_messages).to include("Email has already been taken")
  # end

  # it "重複したemailがあると登録できない" do
  #   @user.save
  #   another_user = FactoryBot.build(:user)
  #   another_user.email = @user.email
  #   another_user.valid?
  #   expect(@user.errors.full_messages).to include("")
  # end

  it "passwordが空では登録できない" do
    @user.password = ""
    @user.valid?
    expect(@user.errors.full_messages).to include("Password can't be blank")
  end

  it "passwordが半角英字のみでは登録できない" do
    @user.password = "hannkakuonly"
    @user.valid?
    expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
  end

  it "passwordが数字のみでは登録できない" do
    @user.password = "12345678"
    @user.valid?
    expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
    
  end

  it "passwordが５文字以下では登録できない" do
    @user.password = "pass1"
    @user.valid?
    expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    
  end

  it "passwordとpassword_confirmationが一致しなければ登録できない" do
    @user.password = "1234abc"
    @user.password_confirmation = "abcd123"
    @user.valid?
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
  end

  it "passwordを記述してもpassword_confirmationが空では登録ができない" do
    @user.password_confirmation = ""
    @user.valid?
    expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
  end

  it "last_nameが空では登録できない"do
  @user.last_name = ""
  @user.valid?
  expect(@user.errors.full_messages).to include("Last name 全角文字を使用してください")
  end

  it "first_nameが空では登録できない"do
  @user.first_name = ""
  @user.valid?
  expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
  end

  it 'first_nameとlast_nameが英字では登録できない' do
    @user.first_name = "tarou"
    @user.last_name = "yamada"
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name 全角文字を使用してください")
  end

  it 'first_nameとlast_nameが半角では登録できない' do
    @user.first_name = "ﾔﾏﾀﾞ"
    @user.last_name = "ﾀﾛｳ"
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name 全角文字を使用してください")
  end

  it 'first_nameとlast_nameが数字では登録できない' do
    @user.first_name = "1234"
    @user.last_name = "5678"
    @user.valid?
    expect(@user.errors.full_messages).to include("First name 全角文字を使用してください", "Last name 全角文字を使用してください")
  end

  it "kana_last_nameが空では登録できない"do
  @user.kana_last_name = ""
  @user.valid?
  expect(@user.errors.full_messages).to include("Kana last name can't be blank")
  end

  it "kana_first_nameが空では登録できない"do
  @user.kana_first_name = ""
  @user.valid?
  expect(@user.errors.full_messages).to include("Kana first name can't be blank")
  end

  it 'kana_first_nameとkana_last_nameが半角では登録できない' do
    @user.kana_first_name = "ﾔﾏﾀﾞ"
    @user.kana_last_name = "ﾀﾛｳ"
    @user.valid?
    expect(@user.errors.full_messages).to include("Kana first name 全角文字でカナを使用してください")
  end

  it 'kana_first_nameとkana_last_nameが漢字では登録できない' do
    @user.kana_first_name = "山田"
    @user.kana_last_name = "太朗"
    @user.valid?
    expect(@user.errors.full_messages).to include("Kana first name 全角文字でカナを使用してください", "Kana last name 全角文字でカナを使用してください")
  end

  it 'first_name_kanaとlast_name_kanaがひらがなでは登録できない' do
    @user.kana_first_name = "やまだ"
        @user.kana_last_name = "たろう"
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first name 全角文字でカナを使用してください", "Kana last name 全角文字でカナを使用してください")
  end

  it 'first_name_kanaとlast_name_kanaが英字では登録できない' do
    @user.kana_first_name = "yamada"
    @user.kana_last_name = "taro"
    @user.valid?
    expect(@user.errors.full_messages).to include("Kana first name 全角文字でカナを使用してください", "Kana last name 全角文字でカナを使用してください")
  end

  it 'kana_first_nameとkana_last_nameが数字では登録できない' do
    @user.kana_first_name = "1234"
    @user.kana_last_name = "5678"
    @user.valid?
    expect(@user.errors.full_messages).to include("Kana first name 全角文字でカナを使用してください", "Kana last name 全角文字でカナを使用してください")
  end

  it "birthdayが空では登録できない"do
  @user.birthday = ""
  @user.valid?
  expect(@user.errors.full_messages).to include("Birthday can't be blank")
  end
end




  describe "ログイン/ユーザー情報" do
    context "ログインできる時" do
      it "登録したemailとpasswordであれば登録ができる" do
      expect(@user).to be_valid
      end
    end

    context "ログインできない時" do
      it "emailが空ではログインできない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "passwordが空ではログインできない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "登録したemailとpasswordに相違があればログインできない" do
        @user.password = "abcd123"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
    # describe "ログイン/ユーザー情報" doのend
  end
# 最後のend
end
