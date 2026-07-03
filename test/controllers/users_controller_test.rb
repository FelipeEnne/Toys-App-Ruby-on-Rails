require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @other_user = users(:two)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: {
        user: {
          name: "New User",
          email: "new@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_url(@user)
    assert_redirected_to login_url
  end

  test "should get edit when logged in as correct user" do
    log_in_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_url(@user)
    assert_redirected_to root_url
  end

  test "should update user when logged in as correct user" do
    log_in_as(@user)
    patch user_url(@user), params: { user: { name: @user.name, email: @user.email, password: "", password_confirmation: "" } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user when logged in as correct user" do
    log_in_as(@user)
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
