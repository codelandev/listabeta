CarrierWave.configure do |config|
  config.storage = (Rails.env.production? || Rails.env.staging?) ? :fog : :file

  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     Rails.application.secrets.aws_access_key.to_s,
    aws_secret_access_key: Rails.application.secrets.aws_secret_key.to_s
  }

  config.fog_directory = Rails.application.secrets.aws_bucket_name.to_s
  config.store_dir = "#{Rails.env}/uploads"
  config.enable_processing = false if Rails.env.test? or Rails.env.cucumber?
end
