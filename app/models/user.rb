class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション(関連付け)
  belongs_to :occupation

  # バリデーション（検証）
  validates :last_name,:first_name,:nickname,length: {minimum: 1, maximum: 10}
  validates :introduction,length: {maximum: 200}

end
