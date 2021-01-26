class User < ApplicationRecord  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

        # パスワードのバリデーションーPASSWORD_REGEXに条件を代入している。
        PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
        validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' 
      
        # バリデーションー空ではないことを記述
      with_options presence: true do
          validates :nickname
          validates :birthday
          validates :email,:password,:password_confirmation
        end

        # 正規表現ー全角文字の記入のみ許可
      with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: '全角文字を使用してください' } do
          validates :first_name
          validates :last_name
        end

        # 正規表現ー全角のカナでのカウントのみ許可
      with_options presence: true, format: { with: /\A[ァ-ヶ]+\z/, message: '全角文字でカナを使用してください' } do
        validates :kana_first_name
        validates :kana_last_name
        end
        
end
