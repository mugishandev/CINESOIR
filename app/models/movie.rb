class Movie < ApplicationRecord
  has_many :markers, dependent: :destroy
  has_many :lists, through: :markers
end
