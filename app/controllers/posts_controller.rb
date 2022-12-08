class PostsController < ApplicationController
  before_action:authenticate_user,{only:[:index,:show,:edit,:update]}
  def index
    # viewで定義していた配列postsを@postsという変数名で定義してください
    @posts = Post.all.order(created_at: :desc)
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
    @post=Post.new(url:params[:url],title:@Ti,summary:@Su,keyword:@Ke)
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
