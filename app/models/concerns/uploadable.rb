module Uploadable
  extend ActiveSupport::Concern

  included do
    field :upload_ids, type: Array, default: []
  end

  def uploads
    @_uploads ||= Upload.where(:id.in => upload_ids).to_a
  end

  def has_uploads?
    upload_ids.present?
  end

  def asset_url
    if has_uploads?
      uploads.last.url
    end
  end
end