class StoriesController < BaseController

  before_filter :find_story, only: [:new, :show, :create, :edit, :update]
  before_filter :get_associated, only: [:show, :edit, :update, :create]

  def new

  end

  def create
    create_story

    send_story_email_from(current_user)

    redirect_to story_path(@story)
  end

  def update
    @story.update_attributes(story_params)

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

  def create_story
    @story.title = story_params[:title]
    @story.body = story_params[:body]
    @story.creator_id = current_user.id
    @story.parent_id = story_params[:parent_id]
    @story.parent_type = story_params[:parent_type]

    @story.save
  end

  def story_params
    params.require(:story).permit(:title, :body, :parent_id, :parent_type)
  end

  def get_associated
    @parent ||= @story.parent
    @creator ||= @story.creator
  end

  def new_story
    atts = {}
    if story_params
      atts = { parent_type: story_params[:parent_type],
               parent_id:   story_params[:parent_id],
               creator_id:  current_user.id }
    end

    Story.new(atts)
  end

  def send_story_email_from(creator)
    for user in @parent.users
      message = StoryNotifier.send_story_email(@story, creator, user, request.host_with_port)
      message.deliver!
    end
  end

end