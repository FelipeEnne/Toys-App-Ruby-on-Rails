require "test_helper"

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @micropost = microposts(:one)
  end

  test "should get index" do
    get microposts_url
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get new_micropost_url
    assert_redirected_to login_url
  end

  test "should get new when logged in" do
    log_in_as(@user)
    get new_micropost_url
    assert_response :success
  end

  test "should create micropost when logged in" do
    log_in_as(@user)
    assert_difference("Micropost.count") do
      post microposts_url, params: { micropost: { content: "New content" } }
    end

    assert_redirected_to micropost_url(Micropost.last)
    assert_equal @user, Micropost.last.user
  end

  test "should show micropost" do
    get micropost_url(@micropost)
    assert_response :success
  end

  test "should get edit when logged in as owner" do
    log_in_as(@user)
    get edit_micropost_url(@micropost)
    assert_response :success
  end

  test "should update micropost when logged in as owner" do
    log_in_as(@user)
    patch micropost_url(@micropost), params: { micropost: { content: "Updated content" } }
    assert_redirected_to micropost_url(@micropost)
  end

  test "should destroy micropost when logged in as owner" do
    log_in_as(@user)
    assert_difference("Micropost.count", -1) do
      delete micropost_url(@micropost)
    end

    assert_redirected_to microposts_url
  end
end
