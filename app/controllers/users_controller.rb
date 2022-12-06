class UsersController < ApplicationController
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
      redirect_to("/users/#{@user.id}")
      flash[:notice]="ユーザー登録が完了しました"
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
end
