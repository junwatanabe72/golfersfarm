class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only: [:tnew,:message, :edit,  :update,  :destroy]
  before_action :checked_open_user, only: [:show, :swing, :gear,:history]
  before_action :ensure_correct_user, only: [:tnew,:edit,  :update]
  
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(48)
    @open_users = User.where(status: 0).order(id: :desc).page(params[:page]).per(48)
    #並び替え
    @q = @users.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def show
      set_user
  end

  def message
      set_user
      @messages = current_user.messages.order(id: :desc).page(params[:page]).per(5)
      @message = current_user.messages.build 
      @messagees = current_user.messages.where(receiver_id: params[:id]).page(params[:page]).per(5)
      @rmessages = current_user.reverses_of_message.order(id: :desc).page(params[:page]).per(5)
      counts(@user)
  end


  def swing
      set_user
  end

  def gear
      set_user
      
  end

  def history
      set_user
      @tournaments= set_user.tournaments.order(year: :desc).page(params[:page]).per(6)
  end


  def tnew
   @user = current_user
   @tournament = current_user.tournaments.build
   @tournaments= current_user.tournaments.order(year: :desc)
  end


  def new
     @user = User.new
    
  end

  def create
      @user = User.new(user_params)
    if @user.save
        #UserMailer.account_activation(@user).deliver_now
        #flash[:info] = "アカウント有効化のため、メール送信しました。ご確認ください。"
        redirect_to root_url
      else
        render 'new'
    end
  end

  def edit
    set_user
  end

  def update
     set_user
      if @user.update(user_params)
        flash[:success] = '値を変更しました。'
        redirect_to edit_user_path(@user)
      else
        flash.now[:danger] = '変更に失敗しました。'
        render :edit
      end
  end

  def destroy
    set_user
    @user.destroy
    flash[:success] = 'ユーザー登録を削除しました'
    redirect_to toppages_url
  end


 private

  def user_params
    params.require(:user).permit(
      :name, :email, :password, :password_confirmation, :image, :gear,
      :hcourse ,:distance, :address, :bplace, :bscore, :status, :video,
      :sex, :channel, :job, :school,  :hobby, :driver,  :dshaft,  :wood, 
      :ut,  :iron,  :wedge, :putter)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  
  def checked_open_user
    set_user
    unless current_user
      if @user.status == "closed"
        redirect_to root_url
      end
    end
  end
  
  def ensure_correct_user
    if current_user.id != params[:id].to_i
      redirect_to root_url
    end
  end

end
