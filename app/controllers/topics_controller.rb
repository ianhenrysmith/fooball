class TopicsController < BaseController

  before_filter :find_topic, only: [:new, :show, :create, :edit, :update]
  before_filter :get_associated, only: [:show, :edit, :update, :create]

  RESOURCE_NAME = :topic
  WHITELISTED_PARAMS = [:title, :body, :parent_id, :parent_type]

  def new

  end

  def create
    create_topic

    redirect_to topic_path(@topic)
  end

  def update
    @topic.attributes = mass_assignable_atts

    @topic.save

    redirect_to topic_path(@topic)
  end

  def show
    @comments = @topic.children

    if @comments.present?
      comment_creator_ids = @comments.map(&:creator_id)
      @users = User.where(:id.in => comment_creator_ids).to_a
    end
  end

  def edit

  end

  private

  def find_topic
    if params[:id]
      @topic ||= Topic.find(params[:id])
    end

    @topic ||= new_topic
  end

  def create_topic
    @topic.attributes = mass_assignable_atts

    process_uploads(asset_params, @topic)

    @topic.save
  end

  def get_associated
    @parent ||= @topic.parent
    @creator ||= @topic.creator
  end

  def new_topic
    atts = mass_assignable_atts
    atts[:creator_id] = current_user.id

    Topic.new(atts)
  end

end