require "test_helper"

class StopwordsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get stopwords_new_url
    assert_response :success
  end

  test "should get create" do
    get stopwords_create_url
    assert_response :success
  end
end
