
class Story
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :body, type: String
  field :creator_id, type: BSON::ObjectId
  field :parent_id, type: BSON::ObjectId
  field :parent_type, type: String

  def self.for_parent(p)
    where(parent_id: p.id)
  end

  def creator
    User.find(creator_id)
  end

  def parent
    parent_type.constantize.find(parent_id)
  end
end