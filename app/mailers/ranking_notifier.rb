class RankingNotifier < ActionMailer::Base
  default from: "notifications@fooball.herokuapp.com"

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_ranking_email(ranking, ranking_creator, user, league)
    @ranking = ranking
    @ranking_creator = ranking_creator
    @user = user
    @league = league

    mail( 
      to: @user.email,
      subject: "#{@ranking_creator.name} just created rankings for week #{@ranking.week}",
      from: "notifications@fooball.herokuapp.com"
    )
  end
end
