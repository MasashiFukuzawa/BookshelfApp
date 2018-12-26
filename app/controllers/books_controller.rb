class BooksController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(books_params)
    if @book.save
      flash[:success] = "New books added to your bookshelf!"
      redirect_to root_url
    else
      @feed_items = []
      render 'new'
    end
  end

  def edit
    @book = Book.find_by(id: params[:id])
  end

  def update
    @book = Book.find_by(id: params[:id])
    if @book.update_attributes(books_params)
      flash[:success] = "Content updated"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    flash[:success] = "Book deleted"
    redirect_back(fallback_location: root_url)
  end

  private

    def books_params
      params.require(:book).permit(:title, :content)
    end

    def correct_user
      @book = current_user.books.find_by(id: params[:id])
      redirect_to root_url if @book.nil?
    end
end
