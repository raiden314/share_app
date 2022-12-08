class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :authenticate_user,{only:[:index,:show,:edit,:update]}
  
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
  
  # authenticate_userメソッドを定義してください
  def authenticate_user
    if @current_user==nil
      flash[:notice]="ログインが必要です"
      redirect_to("/login")
    end
  end
  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/users/index")
    end
  end
end
