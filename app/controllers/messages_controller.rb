class MessagesController < ApplicationController
  
   before_action :require_user_logged_in
   before_action :correct_user, only: [:destroy]
  
  def create
    
    if  @message = current_user.messages.build(message_params)
      if @message.save
        flash[:success] = 'メッセージを投稿しました。'
        redirect_to root_url
      else
        @messages = current_user.messages.order(id: :desc).page(params[:page])
        flash.now[:danger] = 'メッセージの投稿に失敗しました。'
        render 'toppages/index'
      end
    else
      @rmessage = current_user.reverses_of_message.build(message_params)
      if @rmessage.save
        flash[:success] = 'メッセージを投稿しました。'
        redirect_to root_url
      else
        @rmessages = current_user.reverses_of_message.order(id: :desc).page(params[:page])
        flash.now[:danger] = 'メッセージの投稿に失敗しました。'
        render 'toppages/index'
      end
    end
  end

  def destroy
    if
      @message.destroy
        flash[:success] = 'メッセージを削除しました。'
          redirect_back(fallback_location: root_path)
    else
    @message.destroy
        flash[:success] = 'メッセージを削除しました。'
          redirect_back(fallback_location: root_path)
    end
  end
  
  
   private

  def message_params
    params.require(:message).permit(:content , :receiver_id, :user_id)
  end
  
  def correct_user
    if
      @message = current_user.messages.find_by(id: params[:id])
      unless @message
        redirect_to root_url
      end
    else
      @rmessage = current_user.reverses_of_message.find_by(id: params[:id])
      unless @rmessage
        redirect_to root_url
      end
    end
  end

end