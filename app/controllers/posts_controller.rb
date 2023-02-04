class PostsController < ApplicationController
  before_action:authenticate_user,{only:[:index,:show,:edit,:update]}
  before_action:ensure_correct_group_user_p,{only: [:show]}

  #同じグループではない人を弾く
  def ensure_correct_group_user_p
    @user=User.find(@current_user.id)
    if @user.gid != User.find_by(id:Post.find(params[:id]).user_id).gid
      binding.pry
      if Post.find_by(id: params[:id]).user_id != @user.id
        # flash[:notice]="権限がありません"
        redirect_to("/users/#{@current_user.id}")
      end
    end
  end

  def index
    if @current_user.gid.present?
      @posts = Post.where(user_gid: @current_user.gid)
    else
      @posts = Post.where(user_id: "#{@current_user.id}")
    end
  end
  def show
    @post = Post.find_by(id:params[:id])
    if @current_user.gid != @post.user_gid
      # flash[:notice]="権限がありません"
      redirect_to("/users/index")
    end
    
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
        # flash[:notice]="投稿を作成しました"
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
      # flash[:notice]="投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit",status: :unprocessable_entity)
    end
  end
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    # flash[:notice]="投稿を削除しました"
    redirect_to("/posts/index")
  end
end
