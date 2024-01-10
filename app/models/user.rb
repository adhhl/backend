class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: self

  has_many :cards, dependent: :destroy
  has_many :decks, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :nickname, presence: true, uniqueness: true
end
