require 'test_helper'

class CrimesControllerTest < ActionController::TestCase
  setup do
    @crime = crimes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:crimes)
  end

  test "should create crime" do
    assert_difference('Crime.count') do
      post :create, crime: { MaxOfnum_victims: @crime.MaxOfnum_victims, Shift: @crime.Shift, UC2_Literal: @crime.UC2_Literal, beat: @crime.beat, location: @crime.location, neighborhood: @crime.neighborhood, occur_date: @crime.occur_date, occur_time: @crime.occur_time, offense_id: @crime.offense_id, poss_date: @crime.poss_date, poss_time: @crime.poss_time, rpt_date: @crime.rpt_date, x: @crime.x, y: @crime.y }
    end

    assert_response 201
  end

  test "should show crime" do
    get :show, id: @crime
    assert_response :success
  end

  test "should update crime" do
    put :update, id: @crime, crime: { MaxOfnum_victims: @crime.MaxOfnum_victims, Shift: @crime.Shift, UC2_Literal: @crime.UC2_Literal, beat: @crime.beat, location: @crime.location, neighborhood: @crime.neighborhood, occur_date: @crime.occur_date, occur_time: @crime.occur_time, offense_id: @crime.offense_id, poss_date: @crime.poss_date, poss_time: @crime.poss_time, rpt_date: @crime.rpt_date, x: @crime.x, y: @crime.y }
    assert_response 204
  end

  test "should destroy crime" do
    assert_difference('Crime.count', -1) do
      delete :destroy, id: @crime
    end

    assert_response 204
  end
end
