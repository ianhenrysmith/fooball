module Uploadable
  extend ActiveSupport::Concern

  included do
    field :upload_ids, type: Array, default: []
  end

  def uploads
    Upload.where(:id.in => upload_ids)
  end
  
  def add_upload(upload)
    clear_existing_uploads
    
    upload_ids << upload.id
  end

  def has_uploads?
    upload_ids.present?
  end
  
  def upload_url
    @_upload_url ||= if has_uploads?
      uploads.last.url
    end
  end
  
  def clear_existing_uploads
    if has_uploads?
      uploads.delete_all
      
      upload_ids = []
    end
  end
end