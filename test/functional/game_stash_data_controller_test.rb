require 'test_helper'

class GameStashDataControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    sign_in @user
    @game_stash_datum = game_stash_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_stash_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_stash_datum" do
    assert_difference('GameStashDatum.count') do
      post :create, game_stash_datum: { rating: @game_stash_datum.rating }, game_id: 1
    end

    assert_redirected_to game_path(1)
  end

  test "should show game_stash_datum" do
    get :show, id: @game_stash_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game_stash_datum
    assert_response :success
  end

  test "should update game_stash_datum" do
    put :update, id: @game_stash_datum, game_stash_datum: { rating: @game_stash_datum.rating }
    assert_redirected_to game_stash_datum_path(assigns(:game_stash_datum))
  end

  test "should destroy game_stash_datum" do
    assert_difference('GameStashDatum.count', -1) do
      delete :destroy, id: @game_stash_datum
    end

    assert_redirected_to game_stash_data_path
  end
end
