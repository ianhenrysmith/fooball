class CommentsController < BaseController

  before_filter :get_comment, only: [:edit, :new, :update, :create]
  before_filter :get_associated, only: [:edit, :new, :create]

  RESOURCE_NAME = :comment
  WHITELISTED_PARAMS = [:body, :parent_id, :parent_type, :creator_id]

  def new

  end

  def create
    update_resource

    flash.notice = "Comment created"

    redirect_to polymorphic_url(@parent)
  end

  def edit
    # not used
  end

  def update
    # not used
  end

  private

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
