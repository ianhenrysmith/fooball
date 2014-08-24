class CommentsController < BaseController

  before_filter :get_comment, only: [:edit, :new, :update, :create]
  before_filter :get_associated, only: [:edit, :new, :create]

  def new

  end

  def create
    create_comment

    flash.notice = "Comment created"

    redirect_to polymorphic_url(@parent)
  end

  def edit

  end

  def update

  end

  private

  def create_comment
    @comment.update_attributes(comment_params)
  end

  def comment_params
    c = params.require(:comment).permit(:body, :parent_id, :parent_type)
    c[:creator_id] = current_user.id

    c
  end

  def get_comment
    @comment ||= new_comment
  end

  def new_comment
    Comment.new(comment_params)
  end

  def get_associated
    @parent ||= @comment.parent
  end

end
