class TeamsController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'application'

  before_action :authenticate_user!

  def index
  
  end

  def show
    @team = Team.find(params[:id])
    @owner = @team.owner
    @league = @team.league
  end

end