class Stopword < ApplicationRecord
  validates :word, presence: true
end
