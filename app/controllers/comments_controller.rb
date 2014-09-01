class CommentsController < BaseController

  before_filter :get_comment, only: [:edit, :new, :update, :create]
  before_filter :get_associated, only: [:edit, :new, :create]

  RESOURCE_NAME = :comment
  WHITELISTED_PARAMS = [:body, :parent_id, :parent_type, :creator_id]

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
    @comment.update_attributes(mass_assignable_atts)
  end

  def get_comment
    @comment ||= new_comment
  end

  def new_comment
    atts = mass_assignable_atts
    atts[:creator_id] = current_user.id
    
    Comment.new(atts)
  end

  def get_associated
    @parent ||= @comment.parent
  end

end
