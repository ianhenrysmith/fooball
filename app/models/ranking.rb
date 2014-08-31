
class Ranking

  include Postable
  include Uploadable

  field :week, type: Integer
  field :created_at_date, type: Date

  START_OF_SEASON = Date.parse('7/9/2014') # Sun, 07 Sep 2014
  END_OF_SEASON = Date.parse('28/12/2014') # Dec 28
  START_WEEK = 36 # START_OF_SEASON.cweek + 1

  field :team_rankings, type: Hash # { position => { team_id => <id>, comment => <comment>} }

  field :league_id, type: BSON::ObjectId


  def self.for_week(wk)
    where(week: wk)
  end

  def league
    @league ||= League.find(league_id)
  end

  def set_created_at_date(date)
    self.created_at_date = date

    set_week(date)
  end

  def set_week(date=Date.today)
    self.week = week_for_date(date)
  end

  private

  def week_for_date(date)
    return 0 if date < START_OF_SEASON
    return 17 if date > END_OF_SEASON

    date.cweek - START_WEEK
  end

end