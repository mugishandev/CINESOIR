class Movie < ApplicationRecord
  has_many :markers, dependent: :destroy
  has_many :lists, through: :markers
  has_many :chats, dependent: :destroy
end
