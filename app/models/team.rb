
class Team
  include Mongoid::Document
  include Mongoid::Timestamps


  field :name, type: String
  field :image_url, type: String
  field :owner_id, type: BSON::ObjectId
  field :league_id, type: BSON::ObjectId

  def self.for_league(league)
    where(:league_id.in => [league.id])
  end

  def self.for_user(user)
    where(owner_id: user.id)
  end

  def owner
    User.find(owner_id)
  end

  def owner=(user)
    owner_id = user.id
  end

  def league
    League.find(league_id)
  end

  def league=(league)
    league_id = league.id
  end
end