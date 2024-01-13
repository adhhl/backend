class FsrsService
  include HTTParty

  def initialize cards
    @endpoint = ENV["fsrs_url"]
    @cards = cards
    @header = {"Content-Type" => "application/json; charset=utf-8"}
  end

  def update_fsrs rating
    hash_card = @cards.to_log_card_format
    puts @cards.to_json
    rating_str = {0 => "Again", 1 => "Hard", 2 => "Good", 3 => "Easy"}
    hash_card["rating_now"]["rating"] = rating_str[rating.to_i]
    response = HTTParty.post @endpoint,
                             body: hash_card.to_json,
                             headers: @header
    card = JSON.parse(response.body)
    @cards.next_review = card["due"]
    @cards.stability = card["stability"]
    @cards.difficulty = card["difficulty"]
    @cards.state = card["state"]
    puts @cards.to_json
    @cards.save
  end

  def get_due_predict
    rating = {again: "Again", hard: "Hard", good: "Good", easy: "Easy"}
    @cards.each do |card|
      card.dues_predict = ""
      dues = []
      hash_card = card.to_log_card_format
      rating.each do |_, value|
        hash_card["rating_now"]["rating"] = value
        response = HTTParty.post @endpoint,
                                 body: hash_card.to_json,
                                 headers: @header
        due = JSON.parse(response.body)["due"]
        time = hash_card["log_card"]["last_review"]
        dues << time_left(time, due).to_s
      end
      card.dues_predict = dues.join(",")
      card.save
    end
  end

  def time_left last_review, due
    time_diff = Time.zone.parse(due) - Time.zone.parse(last_review)
    seconds = time_diff.to_i
    case
    when seconds < 60
      "#{seconds} seconds"
    when seconds < 3600
      "#{(seconds / 60).to_i} minutes"
    when seconds < 86_400
      "#{(seconds / 3600).to_i} hours"
    else
      "#{(seconds / 86_400).to_i} days"
    end
  end
end
