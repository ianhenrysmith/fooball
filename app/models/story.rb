
class Story
  include Postable
  include Uploadable

  field :title, type: String

  def children
    Comment.for_parent(self).to_a
  end

  def name
    title
  end
end