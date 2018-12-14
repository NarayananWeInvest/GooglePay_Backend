require 'test_helper'

class RulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rule = rules(:one)
  end

  test "should get index" do
    get rules_url, as: :json
    assert_response :success
  end

  test "should create rule" do
    assert_difference('Rule.count') do
      post rules_url, params: { rule: { limit: @rule.limit, max_range: @rule.max_range, min_range: @rule.min_range, period: @rule.period, scratch_card_min: @rule.scratch_card_min, scrathch_card_max: @rule.scrathch_card_max, type: @rule.type } }, as: :json
    end

    assert_response 201
  end

  test "should show rule" do
    get rule_url(@rule), as: :json
    assert_response :success
  end

  test "should update rule" do
    patch rule_url(@rule), params: { rule: { limit: @rule.limit, max_range: @rule.max_range, min_range: @rule.min_range, period: @rule.period, scratch_card_min: @rule.scratch_card_min, scrathch_card_max: @rule.scrathch_card_max, type: @rule.type } }, as: :json
    assert_response 200
  end

  test "should destroy rule" do
    assert_difference('Rule.count', -1) do
      delete rule_url(@rule), as: :json
    end

    assert_response 204
  end
end
