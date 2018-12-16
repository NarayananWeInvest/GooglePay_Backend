require_dependency "services/scratch_card_operations.rb"

class Api::V1::ScratchCardsController < ApplicationController
  before_action :set_scratch_card, only: [:show, :update, :destroy]

  # GET /scratch_cards
  def index
    @scratch_cards = ScratchCard.all

    render json: @scratch_cards
  end

  # GET /scratch_cards/1
  def show
    render json: @scratch_card
  end

  # POST /scratch_cards
  def create
    # @scratch_card = ScratchCard.new(scratch_card_params)

    # if @scratch_card.save
    #   render json: @scratch_card, status: :created, location: @scratch_card
    # else
    #   render json: @scratch_card.errors, status: :unprocessable_entity
    # end
    Puts "save card"
    @result = ScratchCardOperations.new
    render :json => {"result" => @result}
  end

  # PATCH/PUT /scratch_cards/1
  def update
    if @scratch_card.update(scratch_card_params)
      render json: @scratch_card
    else
      render json: @scratch_card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /scratch_cards/1
  def destroy
    @scratch_card.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scratch_card
      @scratch_card = ScratchCard.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def scratch_card_params
      params.require(:scratch_card).permit(:user_id, :amount_won)
    end
end
