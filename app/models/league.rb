
class League
  include Mongoid::Document
  include Mongoid::Timestamps

  include Uploadable


  field :name, type: String
  field :image_url, type: String
  field :user_ids, type: Array, default: []
  field :admin_ids, type: Array, default: []
  field :creator_id, type: Moped::BSON::ObjectId
  field :team_ids, type: Array, default: []

  def self.with_user(user)
    where(:user_ids.in => [user.id])
  end

  def creator
    User.find(creator_id)
  end

  def creator=(user)
    creator_id = user.id
  end

  def users
    User.for_league(self).to_a
  end

  def admins
    User.where(:id.in => admin_ids).to_a
  end

  def teams
    Team.where(:id.in => team_ids).to_a
  end

  def admin?(user)
    admin_ids.include?(user.id)
  end
end