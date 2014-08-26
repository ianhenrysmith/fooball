module Uploadable
  extend ActiveSupport::Concern

  included do

    field :upload_ids, type: Array, default: []

  end

  def uploads
    Upload.where(:id.in => upload_ids).to_a
  end
end