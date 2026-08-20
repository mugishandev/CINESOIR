class Marker < ApplicationRecord
  belongs_to :list
  belongs_to :movie
  validates :movie_id, presence: true
end
