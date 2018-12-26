require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @book = books(:orange)
  end

  test "sould redirect new when not logged in" do
    get new_book_path
    assert_redirected_to login_url
  end
  
  test "sould redirect create when not logged in" do
    assert_no_difference "Book.count" do
      post books_path, params: {book: {
            title: "Ruby on Rails",
            content: "This book is so easy to understand for beginners!"}}
    end
    assert_redirected_to login_url
  end
    
  test "sould redirect edit when not logged in" do
    get edit_book_path(@user)
    assert_redirected_to login_url
  end
  
  test "sould redirect update when not logged in" do
    assert_no_difference "Book.count" do
      patch book_path(@user), params: {book:{
            title: @book.title, content: @book.content}}
    end
    assert_redirected_to login_url
  end
  
  test "should not allow the other user to be edited via the web" do
    log_in_as(@user)
    book = books(:ants)
    assert_no_difference 'Book.count' do
      patch user_path(users(:archer)), params: {
      book: {title: "Ruby on Rails",
            content: "This book is not good for me."}}
    end
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Book.count" do
      delete book_path(@book)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong book" do
    log_in_as(@user)
    book = books(:ants)
    assert_no_difference 'Book.count' do
      delete book_path(book)
    end
    assert_redirected_to root_url
  end
end