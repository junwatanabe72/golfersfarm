class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only: [:show, :index]
  
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
      @user = User.find(params[:id])
      @messages = current_user.messages.order(id: :desc).page(params[:page])
      @message = current_user.messages.build
      #@rmessages = @user.reverses_of_message.order(id: :desc).page(params[:page])
      #@rmessage = @user.reverses_of_message.build
      counts(@user)
  end

  def new
     @user = User.new
  end

  def create
      @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
     @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:success] = '値を変更しました。'
        redirect_to @user
      else
        flash.now[:danger] = '変更に失敗しました。'
        render :edit
      end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = 'ユーザー登録を削除しました'
    redirect_to toppages_url
  end


 private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :distance, :address, :bplace, :bscore)
  end
  
  
end
