class PostsController < ApplicationController
  def index
    # viewで定義していた配列postsを@postsという変数名で定義してください
    @posts = [
      "今日からProgateでRailsの勉強するよー！",
      "投稿一覧ページ作成中！"
    ]
  end
end
