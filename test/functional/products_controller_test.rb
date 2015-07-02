require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should get index" do
    get :index
    assert_redirected_to new_user_session_path
  end

  test "should create product" do
    post :create, :product => { :asset_name => 'scfd', :image => 'dffff.jpg'}
    assert_redirected_to new_user_session_path
  end

end
