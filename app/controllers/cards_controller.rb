class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_deck
  before_action :set_card, only: %i(show update destroy)

  # GET /cards
  # GET /cards.json
  def index
    # redis_key = "decks/#{params[:deck_id]}/cards/#{current_user.id}"
    # if Rails.cache.exist?(redis_key)
    #   @cards = Rails.cache.read(redis_key)
    # else
    #   @cards = @deck.cards
    #   # TODO
    #   # add info about next review when choose state
    #   Rails.cache.write(redis_key, @cards)
    # end
    @cards = @deck.cards
    render json: @cards
  end

  def card_learn_today
    @card = @deck.cards.learn_today
    FsrsService.new(@card).get_due_predict
    render json: @card
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    @card_history = @card.review_histories
    render json: { card: @card, card_history: @card_history }
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new card_params
    @card.user = current_user
    @card.deck = @deck
    if @card.save
      render json: @card, status: :created
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    if @card.update card_params
      render json: @card, status: :ok
    else
      render json: @card.errors, status: :unprocessable_entity
    end

    if params[:card][:rating]
      @card.review_histories.create! rating: params[:card][:rating]
      @card.last_review = Time.zone.now
      FsrsService.new(@card).update_fsrs params[:card][:rating]
      @card.reps += 1
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_card
    @card = @deck.cards.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def card_params
    params.require(:card).permit(:front, :back, :user_id, :deck_id, :rating,
                                 :state, :due, :stability, :difficulty, :reps,
                                 :due_predict,
                                 :next_review)
  end

  def set_deck
    @deck = Deck.find(params[:deck_id])
    return unless @deck.user != current_user

    render json: {error: "Not Allowed"}, status: :forbidden
  end

  def convert_to_time duration
    match_data = duration.match(/(\d+)\s*(second|minute|hour|day)s?/)
    return nil unless match_data

    quantity = match_data[1].to_i
    unit = match_data[2].downcase

    case unit
    when "second"
      quantity.seconds
    when "minute"
      quantity.minutes
    when "hour"
      quantity.hours
    when "day"
      quantity.days
    end
  end
end
