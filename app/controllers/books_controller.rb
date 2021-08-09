class BooksController < ApplicationController
    before_action :authenticate_user!
    before_action :corrent_book, only: [:edit, :update]
    impressionist :actions=> [:show]

  def corrent_book
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end

  def new
    @booknew = Book.new
  end

  def create
    @booknew = Book.new(book_params)
    @booknew.user_id = current_user.id
    if @booknew.save
      redirect_to book_path(@booknew), notice: "You have created book successfully."
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @user = current_user
    @booknew = Book.new
    @books = Book.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
  end

  def show
    @booknew = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @comment = Comment.new
    @comments = @book.comments
    impressionist(@book, nil, unique: [:ip_address])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :rate)
  end

end
