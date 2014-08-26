class Upload
  include Mongoid::Document

  field :parent_id, type: BSON::ObjectId
  field :parent_type, type: String

  mount_uploader :asset, AssetUploader

  def parent
    parent_type.constantize.find(parent_id)
  end

end