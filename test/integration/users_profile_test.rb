require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end
  
  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'div.container>a', 'Add new books!', count: 2
    assert_select 'li>img'
    assert_match @user.books.count.to_s, response.body
    assert_select 'div.pagination', count: 1
    @user.books.paginate(page: 1) do |book|
      assert_match book.title, response.body
      assert_match book.content, response.body
      assert_match book.created_at, response.body
    end
  end
  
end
