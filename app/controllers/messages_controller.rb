class MessagesController < ApplicationController
  
   before_action :require_user_logged_in
   before_action :correct_user, only: [:destroy]
  
  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @messages = current_user.messages.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @message.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
   private

  def message_params
    params.require(:message).permit(:content , :receiver_id)
  end
  
  def correct_user
    @message = current_user.messages.find_by(id: params[:id])
    unless @message
      redirect_to root_url
    end
  end
end
