class StoriesController < BaseController

  before_filter :find_story, only: [:new, :show, :create, :edit, :update]
  before_filter :get_associated, only: [:show, :edit, :update, :create]

  RESOURCE_NAME = :story
  WHITELISTED_PARAMS = [:title, :body, :parent_id, :parent_type]
  PROCESS_ASSETS = true

  def new

  end

  def create
    update_resource

    send_story_email_from(current_user)

    redirect_to story_path(@story)
  end

  def update
    update_resource

    redirect_to story_path(@story)
  end

  def show
    @comments = @story.children

    if @comments.present?
      comment_creator_ids = @comments.map(&:creator_id)
      @users = User.where(:id.in => comment_creator_ids).to_a
    end
  end

  def edit

  end

  private

  def find_story
    if params[:id]
      @story ||= Story.find(params[:id])
    end

    @story ||= new_story
  end

  def get_associated
    @parent ||= @story.parent
    @creator ||= @story.creator
  end

  def new_story
    atts = mass_assignable_atts
    atts[:creator_id] = current_user.id

    Story.new(atts)
  end

  def send_story_email_from(creator)
    for user in @parent.users
      message = StoryNotifier.send_story_email(@story, creator, user, request.host_with_port)
      message.deliver! if Rails.env.production?
    end
  end

end