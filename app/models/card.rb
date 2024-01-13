class Card < ApplicationRecord
  belongs_to :user
  belongs_to :deck
  has_many :review_histories, dependent: :destroy

  enum rating: {again: 0, hard: 1, good: 2, easy: 3}, _prefix: true

  enum state: {new: 0, learning: 1, review: 2, relearning: 3}, _prefix: true

  scope :learn_today, ->{
     where('next_review IS NULL OR next_review < ?', Time.zone.now)
  }
  scope :not_learn_before, ->{where(next_review: nil)}

  def to_log_card_format
    {
      "log_card" => {
        "id" => id.to_s,
        "stability" => stability.to_s,
        "difficulty" => difficulty.to_s,
        "reps" => reps.to_s,
        "state" => state.to_i,
        "last_review" => last_review.nil? ? updated_at&.strftime("%Y-%m-%d %H:%M:%S.%L") : last_review&.strftime("%Y-%m-%d %H:%M:%S.%L")
      },
      "rating_now" => {
        "rating" => "Easy",
        "rating_time" => updated_at&.strftime("%Y-%m-%d %H:%M:%S.%L")
      }
    }
  end
end
