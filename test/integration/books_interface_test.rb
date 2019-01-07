require 'test_helper'

class BooksInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "book interface" do
    log_in_as @user
    get root_path
    assert_select 'ul.pagination'
    
    get new_book_path
    assert_select 'input[type=file]'
    assert_no_difference 'Book.count' do
      post books_path, params: {book: {title: "", content: ""}}
    end
    assert_select 'div.alert-danger'
    
    title = "test"
    content = "This is a test."
    picture = fixture_file_upload('test/fixtures/test-image.jpg', 'image/jpg')
    assert_difference 'Book.count', 1 do
      post books_path, params: {book: {title: title, content: content, picure: picture}}
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
    assert_match title, response.body
    assert_match content, response.body
    
    title = "Ruby"
    content = "Ruby on Rails"
    first_book = @user.books.page(1).per(5).first
    assert_select 'a', text: "Edit"
    get edit_book_path(first_book)
    assert_select 'input[type=file]'
    patch book_path(first_book), params: {book: {title: title, content: content, picture: picture}}
    assert_not flash.empty?
    assert_select 'div.alert-danger', count: 0
    assert_redirected_to root_url
    follow_redirect!
    assert_match title, response.body
    assert_match content, response.body
    
    assert_select 'a', text: "Delete"
    assert_difference 'Book.count', -1 do
      delete book_path(first_book)
    end
    assert_redirected_to root_url
    assert_no_match title, response.body
    assert_no_match content, response.body
    
    other_user = users(:archer)
    other_book = other_user.books.page(1).per(5).first
    get user_path(other_user)
    assert_select 'a', text: "Edit", count: 0
    get edit_book_path(other_book)
    assert_redirected_to root_url
    patch book_path(other_book), params: {book: {title: title, content: content, picture: picture}}
    assert_redirected_to root_url
    
    get user_path(other_user)
    assert_select 'a', text: "Delete", count: 0
    assert_no_difference 'Book.count' do
      delete book_path(other_book)
    end
    assert_redirected_to root_url
  end
  
  test "book count should be correct" do
    log_in_as(@user)
    get root_path
    assert_match "Number of Books: #{@user.books.count}", response.body
    
    other_user = users(:malory)
    log_in_as(other_user)
    get root_path
    assert_match "Number of Books: 0", response.body
    other_user.books.create!(title: "Ruby", content: "Rails")
    get root_path
    assert_match "Number of Books: #{other_user.books.count}", response.body
  end
end