require 'test_helper'

class LandingPagesControllerTest < ActionDispatch::IntegrationTest
  test "display root landing page" do
    get '/'
    assert_response :success
    assert_select 'h1', 'Quiz Master'
  end
end
