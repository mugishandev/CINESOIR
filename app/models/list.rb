class List < ApplicationRecord
  belongs_to :user
  has_many :movies, through: :markers
  has_many :markers, dependent: :destroy
end
