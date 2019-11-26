class SessionsController < ApplicationController
  def new
    
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
      if @user && @user.authenticate(params[:session][:password])
        if @user.activated?
          log_in @user
          flash[:success] = 'ログインに成功しました。'
          params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          redirect_to @user
        else
          message  = "アカウントが有効化されていません。"
          message += "送信したメールをご確認ください。"
          flash[:warning] = message
          redirect_to root_url
        end
      else
        flash.now[:danger] = 'ログインに失敗しました。'
        render 'new'
      end
  end
  
  def destroy
    log_out
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  

end
