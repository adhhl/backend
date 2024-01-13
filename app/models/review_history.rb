class ReviewHistory < ApplicationRecord
  belongs_to :card

  enum rating: {again: 0, hard: 1, good: 2, easy: 3}, _prefix: true

  validates :rating, presence: true,
            inclusion: {in: ReviewHistory.ratings.keys}

  private
  def update_reps
    card.reps += 1
    card.save
  end
end
