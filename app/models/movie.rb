class Movie < ApplicationRecord
  has_many :lists, through: :markers
  has_many :markers, dependent: :destroy
end
