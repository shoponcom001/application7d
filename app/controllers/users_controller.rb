class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @booknew = Book.new
  end

  def index
    @users = User.all
    @user = current_user
    @booknew = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end
  
  def following
    @user = User.find(params[:id])
    @users = @user.following
    render "show_follow"
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render "show_follower"
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
