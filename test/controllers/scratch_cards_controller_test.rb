require 'test_helper'

class ScratchCardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scratch_card = scratch_cards(:one)
  end

  test "should get index" do
    get scratch_cards_url, as: :json
    assert_response :success
  end

  test "should create scratch_card" do
    assert_difference('ScratchCard.count') do
      post scratch_cards_url, params: { scratch_card: { amount_won: @scratch_card.amount_won, user_id: @scratch_card.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show scratch_card" do
    get scratch_card_url(@scratch_card), as: :json
    assert_response :success
  end

  test "should update scratch_card" do
    patch scratch_card_url(@scratch_card), params: { scratch_card: { amount_won: @scratch_card.amount_won, user_id: @scratch_card.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy scratch_card" do
    assert_difference('ScratchCard.count', -1) do
      delete scratch_card_url(@scratch_card), as: :json
    end

    assert_response 204
  end
end
