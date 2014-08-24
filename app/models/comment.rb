
class Comment
  include Postable

  field :replied_to_ids, type: Array
  
  def replied_to
    User.where(:id.in => replied_to_ids)
  end
end