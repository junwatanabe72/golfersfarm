class SessionsController < ApplicationController
  def new
    
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
        flash[:success] = 'ログインに成功しました。'
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_to @user
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render 'new'
    end
  end
  
  def destroy
    log_out
    #session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      if @user.activated?
      # ログイン成功
        session[:user_id] = @user.id
        return true
      else
        message  = "アカウントが有効化されていません。"
        message += "送信したメールをご確認ください。"
        flash[:warning] = message
        return false
      end
    else
      # ログイン失敗
      return false
    end
  end

end
