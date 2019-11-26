require "rails_helper"

 describe "ユーザー",type: :model do
   
   before do
    @user = User.create
   end
   
   it "ユーザーが登録される" do
    expect(@user).not_to be_valid
   end
   
 end