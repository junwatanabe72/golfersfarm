class TournamentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  
  def create
    @tournament = current_user.tournaments.build(tournament_params)
    if @tournament.save
      flash[:success] = '競技を追加しました。'
      redirect_to tnew_user_url(@tournament.user_id)
    else
      @user = current_user
      @tournaments = current_user.tournaments.order(year: :desc).page(params[:page])
      flash.now[:danger] = "競技を追加できませんでした。"
      render "users/tnew" 
    end
  end


  #def update
      #if @tournament.update(user_params)
        #flash[:success] = '値を変更しました。'
        #redirect_to tnew_user_url(@tournament.user_id)
      #else
        #@user = current_user
        #flash.now[:danger] = '変更に失敗しました。'
        #render "users/tnew"
      #end
  #end


  def destroy
    @tournament.destroy
    flash[:success] = "競技を削除しました。"
    redirect_back(fallback_location: root_path)
  end

  private

  def tournament_params
    params.require(:tournament).permit(:content,:rank,:url,:year)
  end


  def correct_user
    @tournament = current_user.tournaments.find_by(id: params[:id])
    unless @tournament
      redirect_to root_url
    end
  end

end
