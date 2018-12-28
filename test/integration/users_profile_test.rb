require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end
  
  test "my profile display" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_no_match 'div.card-body>a', 'Follow'
    assert_no_match 'div.card-body>a', 'Unfollow'
    assert_select 'a', text: 'Add new books'
    assert_select 'a', text: 'Edit'
    assert_select 'a', text: 'Delete'
    assert_select 'li>img'
    assert_match @user.books.count.to_s, response.body
    assert_select 'div.pagination', count: 1
    @user.books.paginate(page: 1) do |book|
      assert_match book.title, response.body
      assert_match book.content, response.body
      assert_match book.created_at, response.body
    end
    get root_path
    assert_template 'static_pages/home'
    assert_select 'title', full_title("")
    assert_select 'a', text: 'View my profile'
    assert_select 'a', text: 'Add new books'
    assert_select 'li>img'
    assert_select 'div.pagination', count: 1
    @user.books.paginate(page: 1) do |book|
      assert_match book.title, response.body
      assert_match book.content, response.body
      assert_match book.created_at, response.body
    end
  end

  test "other user's profile display" do
    log_in_as(@other_user)
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_no_match 'div.card-body>a', 'Add new books'
    assert_no_match 'p>span a', 'Edit'
    assert_no_match 'p>span a', 'Delete'
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
