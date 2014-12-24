require 'test_helper'

class RestrictedAccessesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:angelo)
  end

  test "should not be able to access email nor password edit pages" do
    get change_passwords_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_url
    get change_emails_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

end
