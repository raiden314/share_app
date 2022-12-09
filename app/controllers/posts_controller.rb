class PostsController < ApplicationController
  before_action:authenticate_user,{only:[:index,:show,:edit,:update]}
  def index
    if @current_user.gid
      @posts = Post.where(user_gid: @current_user.gid)
    else
      if @current_user != 1 
        @posts = Post.where(user_id: "#{@current_user.id}")
      else
        @posts = Post.all.order(id: :asc)
      end
    end
  end
  def show
    @post = Post.find_by(id:params[:id])
  end
  def new
    @post=Post.new
  end
  def create
    page = MetaInspector.new(params[:url])
    @Ti=page.title
    @Su=page.description
    @Ke=page.meta['keywords']
    @post=Post.new(url:params[:url],title:@Ti,summary:@Su,keyword:@Ke,user_id:@current_user.id)
    @post.save
    if @post.save
      # 変数flash[:notice]に、指定されたメッセージを代入してください
      flash[:notice]="投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end
  def edit
    @post = Post.find_by(id: params[:id])
  end
  def update
    @post=Post.find_by(id: params[:id])
    @post.url=params[:url]
    @post.title=params[:title]
    @post.summary=params[:summary]
    @post.keyword=params[:keyword]
    @post.save
    if @post.save
      # 変数flash[:notice]に指定されたメッセージを代入してください
      flash[:notice]="投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice]="投稿を削除しました"
    redirect_to("/posts/index")
  end
end
