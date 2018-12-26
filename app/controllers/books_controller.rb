class BooksController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]

  def new
  end

  def create
    @book = current_user.books.build(books_params)
    if @book.save
      flash[:success] = "New books added to your bookshelf!"
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def books_params
      params.require(:book).permit(:title, :content)
    end
end
