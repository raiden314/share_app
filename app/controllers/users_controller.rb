class UsersController < ApplicationController
  before_action:authenticate_user,{only:[:index,:show,:edit,:update]}
  before_action:forbid_login_user,{only:[:new,:create,:login_form,:login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  def index
    @users = User.all
  end
  def show
    @user = User.find_by(id: params[:id])
  end
  def new
    @user=User.new
  end
  def create
    @user = User.new(name: params[:name], password: params[:password])
    # 保存が成功したかどうかで条件分岐をしてください
    if @user.save
      # 登録されたユーザーのidを変数sessionに代入してください
      session[:user_id]=@user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
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
    if @user.save
      redirect_to("/users/#{@user.id}")
      flash[:notice]="ユーザー情報を編集しました"
    else
      render("users/edit")
    end
  end
  def login_form
    
  end
  def login
    @user = User.find_by(name: params[:name], password: params[:password])
    if @user
      # 変数sessionに、ログインに成功したユーザーのidを代入してください
      session[:user_id]=@user.id
      
      flash[:notice] = "ログインしました"
      redirect_to("/users/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @name = params[:name]
      @password = params[:password]
      render("users/login_form")
    end
  end
  def logout
    session[:user_id]=nil
    flash[:notice]="ログアウトしました"
    redirect_to("/login")
  end
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice]="権限がありません"
      redirect_to("/users/index")
    end
  end
end
