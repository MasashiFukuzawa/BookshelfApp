require 'test_helper'

class BookTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @book = @user.books.build(
                  title: "Ruby on Rails",
                  content: "This book is so easy to understand for beginners!")
  end

  test "should be valid" do
    assert @book.valid?
  end

  test "user id should be present" do
    @book.user_id = nil
    assert_not @book.valid?
  end

  test "title should be present" do
    @book.title = " "
    assert_not @book.valid?
  end

  test "title should be at most 50 characters" do
    @book.title = "a" * 51
    assert_not @book.valid?
  end

  test "content should be present" do
    @book.content = " "
    assert_not @book.valid?
  end

  test "content should be at most 800 characters" do
    @book.content = "a" * 801
    assert_not @book.valid?
  end

  test "order should be most recent first" do
    assert_equal books(:most_recent), Book.first
  end
end
