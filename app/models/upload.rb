class Upload
  include Mongoid::Document

  field :parent_id, type: BSON::ObjectId
  field :parent_type, type: String

  mount_uploader :asset, AssetUploader

  def parent
    parent_type.constantize.find(parent_id)
  end

  def url
    if Rails.env.development?
      asset.cache_stored_file! unless asset.cached?

      "/assets/#{id}/#{asset.cache_name}"
    else
      asset.url
    end
  end

end
# /<   Rails.root  >/                        /<       upload.id      >
# /Users/ian/fooball/tmp/uploads/upload/asset/53fdee7549616ea3d9000000/o-BRONCOS-RAVENS-WEATHER-facebook.jpg"