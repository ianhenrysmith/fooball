class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @leagues = League.with_user(current_user) if current_user

    if @leagues && @leagues.count == 1 # I'm ok with this for now but yeah it kinda sucks
      redirect_to league_path(@leagues.first)
    end
  end

end
