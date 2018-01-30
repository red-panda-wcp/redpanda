class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :lastname, :firstname, :postal_code, :address, :phone, presence: true,on: :create
  validates :kana_lastname, :kana_firstname,  presence: true,on: :create,
  			 format: {
                   with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
                   message: "は全角カタカナで入力して下さい。"
                 }
  # validates :encrypted_password, presence: true, length: { maximum: 6 },on: :create

  enum active: { active: 0, inactive: 1 }


end
