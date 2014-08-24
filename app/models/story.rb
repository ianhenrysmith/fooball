
class Story
  include Postable

  field :title, type: String

  def children
    Comment.for_parent(self).to_a
  end

  def name
    title
  end
end