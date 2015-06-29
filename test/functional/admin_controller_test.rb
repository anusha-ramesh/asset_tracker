require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should get index" do
    get :index
    assert_redirected_to new_user_session_path
  end

end
