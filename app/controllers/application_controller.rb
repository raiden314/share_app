class ApplicationController < ActionController::Base
  before_action :set_current_user
  
  #ログインユーザを記録する
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
  
  #ログインしていないかを判断する
  def authenticate_user
    if @current_user==nil
      # flash[:notice]="ログインが必要です"
      redirect_to("/login")
    end
  end
  #ログインしているかを判断する
  def forbid_login_user
    if @current_user
      # flash[:notice] = "すでにログインしています"
      redirect_to("/users/index")
    end
  end
end
