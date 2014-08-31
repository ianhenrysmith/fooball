
class RankingsController < BaseController

  before_filter :get_ranking, only: [:show, :edit, :new, :update, :create]
  before_filter :get_associated, only: [:show, :edit, :new, :create]

  RESOURCE_NAME = :ranking
  WHITELISTED_PARAMS = [:league_id, :created_at_date, :week, :body, :title]
  DEEP_PARAMS = [:team_rankings]

  def index

  end

  def show

  end

  def new

  end

  def update

  end

  def create
    create_ranking

    redirect_to(@ranking)
  end

  def edit

  end

  private

  def create_ranking
    @ranking.attributes = mass_assignable_atts

    send_ranking_email_from(current_user)

    @ranking.save
  end

  def get_ranking
    if params[:id]
      @ranking ||= Ranking.find(params[:id])
    end

    @ranking ||= new_ranking
  end

  def new_ranking
    atts = { creator_id: current_user.id }

    ranking = Ranking.new(atts.merge(mass_assignable_atts))

    ranking.set_created_at_date(Date.today)

    ranking
  end

  def get_associated
    @league ||= @ranking.league
    @users ||= @league.users
    @teams ||= @league.teams
    @users_by_team_id ||= get_users_by_team_id
  end

  def send_ranking_email_from(creator)
    for user in @users
      message = RankingNotifier.send_ranking_email(@ranking, creator, user, @league)
      message.deliver! if Rails.env.production?
    end
  end

end