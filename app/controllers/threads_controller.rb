class ThreadsController < BaseController
  
  before_filter :find_thread, only: [:new, :show, :create]
  # before_filter :get_associated, only: [:show, :edit, :update]

  def new

  end

  def create

  end

  def show

  end

  private

  def find_thread
    if params[:id]
      @thread ||= Thread.find(params[:id])
    end

    @thread ||= new_thread
  end

  def create_thread
    @thread.title = thread_params[:title]
    @thread.body = thread_params[:body]
    @thread.creator_id = current_user.id
    @thread.parent_id = thread_params[:parent_id]
    @thread.parent_type = thread_params[:parent_type]

    @thread.save
  end

  def thread_params
    params.require(:thread).permit(:title, :body, :parent_id, :parent_type)
  end

  def get_associated
    @parent = @thread.parent
    @creator = @thread.creator
  end

  def new_thread
    Thread.new(parent_type: params[:parent_type], parent_id: params[:parent_id])
  end

end