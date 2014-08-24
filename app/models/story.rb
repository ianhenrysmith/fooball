
class Story
  include Postable

  field :title, type: String

  def children
    Comment.for_parent(self)
  end

  def name
    title
  end
end