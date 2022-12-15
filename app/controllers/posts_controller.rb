class PostsController < ApplicationController
  before_action:authenticate_user,{only:[:index,:show,:edit,:update]}
  def index
    if @current_user.gid.present?
      @posts = Post.where(user_gid: @current_user.gid)
    else
      @posts = Post.where(user_id: "#{@current_user.id}")
    end
    # binding.pry
  end
  def show
    @post = Post.find_by(id:params[:id])
  end
  def new
    @post=Post.new
  end
  def create
    if URI::DEFAULT_PARSER.make_regexp.match(params[:url])
      page = MetaInspector.new(params[:url])
      if page.title.present?
        @Ti=page.title
      else
        @Ti=page.meta['title']
      end
      @Su=page.description
      @Ke=page.meta['keywords']
      @post=Post.new(url:params[:url],title:@Ti,summary:@Su,keyword:@Ke,user_id:@current_user.id,user_gid:@current_user.gid)
      if @post.save
        # 変数flash[:notice]に、指定されたメッセージを代入してください
        flash[:notice]="投稿を作成しました"
        redirect_to("/posts/index")
      else
        render("posts/new",status: :unprocessable_entity)
      end
    else
      @error_message="URLを入力してください"
      render("posts/new",status: :unprocessable_entity)
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
      render("posts/edit",status: :unprocessable_entity)
    end
  end
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice]="投稿を削除しました"
    redirect_to("/posts/index")
  end
end
