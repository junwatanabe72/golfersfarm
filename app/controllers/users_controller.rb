class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only: [:show,  :index, :status,  :edit,  :update,  :destroy]
  before_action :ensure_correct_user, only: [ :edit,  :update]
  
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(50)
    @q = @users.ransack(params[:q])
    @users = @q.result(distinct: true)

  end

  def show
      @user = User.find(params[:id])
      @messages = current_user.messages.order(id: :desc).page(params[:page]).per(5)
      @message = current_user.messages.build 
      @messagees = current_user.messages.where(receiver_id: params[:id]).page(params[:page]).per(5)
      @rmessages = current_user.reverses_of_message.order(id: :desc).page(params[:page]).per(5)
      @rmessage = current_user.reverses_of_message.build
      counts(@user)
  end

  def status
      @user = User.find(params[:id])
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :hcourse ,:distance, :address, :bplace, :bscore)
  end
  
  
  def ensure_correct_user
    if current_user.id != params[:id].to_i
      redirect_to  root_url
    end
  end

end
