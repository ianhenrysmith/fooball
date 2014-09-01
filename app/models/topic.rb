
class Topic
  include Postable
  include Uploadable

  def children
    Comment.for_parent(self).to_a
  end
  
end