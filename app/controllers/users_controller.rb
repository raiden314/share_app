class UsersController < ApplicationController
  before_action:authenticate_user,{only:[:index,:show,:edit,:update]}
  before_action:forbid_login_user,{only:[:new,:create,:login_form,:login]}
  before_action:ensure_correct_user, {only: [:edit, :update]}
  # before_action:individual_user,{only: [:index]}

  def ensure_correct_group_user
    @user=User.find_by(id:@current_user.id)
    if @user.gid != User.find_by(id: params[:id]).gid
      flash[:notice]="権限がありません"
      redirect_to("/users/index")
    end
  end
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice]="権限がありません"
      redirect_to("/users/index")
    end
  end

  def individual_user
    if @current_user.gid.blank?
      redirect_to("/users/#{@current_user.id}")
    end
  end
  
  def index
    if @current_user.gid.present?
      @users = User.where(gid: @current_user.gid)
      @user = User.find_by(gid_m: @current_user.gid)
    else
      @users = User.where(id: "#{@current_user.id}")
    end
    
  end
  def show
    @user = User.find_by(id: params[:id])
  end
  def new
    @user=User.new
  end
  def create
    @user = User.new(name: params[:name], password: params[:password])
    @user.save
    if @user.save
      session[:user_id]=@user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new",status: :unprocessable_entity)
    end
  end
  def edit
    @user = User.find_by(id: params[:id])
  end
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.password = params[:password]
    @user.gid = params[:gid]
    @user.save
    Post.where(user_id:"#{@user.id}").update(user_gid:@user.gid)
    if @user.save
      redirect_to("/users/#{@user.id}")
      flash[:notice]="ユーザー情報を編集しました"
    else
      render("users/edit",status: :unprocessable_entity)
    end
  end
  def login_form
    
  end
  def login
    @user = User.find_by(name: params[:name], password: params[:password])
    if @user
      session[:user_id]=@user.id      
      flash[:notice] = "ログインしました"
      redirect_to("/users/#{@user.id}")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @name = params[:name]
      @password = params[:password]
      render("users/login_form",status: :unprocessable_entity)
    end
  end
  def logout
    session[:user_id]=nil
    flash[:notice]="ログアウトしました"
    redirect_to("/login")
  end
  def g_destroy
    @user = User.find_by(id: params[:id])
    @user.gid = nil
    @user.save
    Post.where(user_id:"#{@user.id}").update(user_gid:"")
    flash[:notice]="グループIDを削除しました"
    redirect_to("/users/#{@user.id}")
  end
  def gm_destroy
    @user = User.find_by(id: params[:id])
    @user.gid_m = @user.id
    @user.gid=""
    @user.gname = nil
    @user.save
    flash[:notice]="管理者用のグループIDを削除しました"
    redirect_to("/users/#{@user.id}")
  end
  def gnew
    @user = User.find_by(id: params[:id])
    if @user.gid_m.to_i == @user.id
      @u_gid = ""
    else
      @u_gid = @user.gid_m
    end
  end
  def gcreate
    @user = User.find_by(id: params[:id])
    @user.gid_m = params[:gid_m]
    @user.gid = params[:gid_m]
    @user.gname = params[:gname]
    @user.save
    Post.where(user_id:"#{@user.id}").update(user_gid:@user.gid)
    if @user.save
      flash[:notice] = "グループの代表者登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      @error_message="そのグループIDは使われています"
      @u_gid=params[:gid_m]
      render("users/gnew",status: :unprocessable_entity)
    end
  end
  def destroy
    @user = User.find_by(id: params[:id])
    Post.where(user_id:"#{@user.id}").update(user_gid:"")
    @user.destroy
    flash[:notice]="ユーザを削除しました"
    redirect_to("/")
  end
end