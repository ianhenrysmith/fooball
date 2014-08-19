
class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :body, type: String
  field :creator_id, type: BSON::ObjectId
  field :parent_id, type: BSON::ObjectId
  field :parent_type, type: String
  field :replied_to_ids, type: Array
  
  def creator
    User.find(creator_id)
  end
  
  def parent
    parent_type.constantize.find(parent_id)
  end
  
  def replied_to
    User.where(:id.in => replied_to_ids)
  end
end