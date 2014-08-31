
CarrierWave.configure do |config|

  if Rails.env.development? || Rails.env.test?
    config.storage = :file
    config.root = Rails.root.join('tmp')
    config.cache_dir = "uploads"

  else
    config.storage = :fog

    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                'us-east-1'
    }
    config.permissions    = 0644
    config.asset_host     = "http://#{ENV['AWS_BUCKET']}.s3.amazonaws.com"
    config.fog_directory  = ENV['AWS_BUCKET']
    config.fog_public     = true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}

  end
end