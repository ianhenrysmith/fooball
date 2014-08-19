
class League
  include Mongoid::Document
  include Mongoid::Timestamps


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
    us = User.for_league(self)
  end

  def admins
    User.where(:id.in => admin_ids).to_a
  end

  def teams
    Team.where(:id.in => team_ids).to_a
  end

end