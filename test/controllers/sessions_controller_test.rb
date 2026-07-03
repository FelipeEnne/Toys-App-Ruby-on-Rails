require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get login_url
    assert_response :success
  end

  test "should log in with valid credentials" do
    post login_url, params: { session: { email: @user.email, password: "password" } }
    assert_redirected_to @user
    assert logged_in?
  end

  test "should reject invalid credentials" do
    post login_url, params: { session: { email: @user.email, password: "wrong" } }
    assert_response :unprocessable_entity
    assert_not logged_in?
  end

  test "should log out" do
    log_in_as(@user)
    delete logout_url
    assert_redirected_to root_url
    assert_not logged_in?
  end

  private

  def logged_in?
    !session[:user_id].nil?
  end
end
