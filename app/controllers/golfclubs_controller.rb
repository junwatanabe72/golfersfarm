class GolfclubsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  
  def create
     @golfclub = current_user.golfclubs.build(golfclub_params)
    if @golfclub.save
      flash[:success] = 'クラブを登録しました。'
      redirect_to cnew_user_url(@golfclub.user_id)
    else
      @user = current_user
      @golfclubs = current_user.golfclubs.all
      flash.now[:danger] = "登録できませんでした。"
      render "users/cnew" 
    end
  end

  def destroy
    @golfclub.destroy
    flash[:success] = "削除しました。"
    redirect_back(fallback_location: root_path)
  end
  
end


  private

  def golfclub_params
    params.require(:golfclub).permit(:driver,:dshaft,:wood,:ut,:iron,:wedge,:putter)
  end

  def correct_user
    @golfclub = current_user.golfclubs.find_by(id: params[:id])
    unless @golfclub
      redirect_to root_url
    end
  end