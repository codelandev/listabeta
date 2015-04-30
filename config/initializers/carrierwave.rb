CarrierWave.configure do |config|
  config.storage = Rails.env.production? ? :fog : :file

  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     Rails.application.secrets.aws_access_key,
    aws_secret_access_key: Rails.application.secrets.aws_secret_key,
  }

  config.fog_directory = Rails.application.secrets.aws_bucket_name
  config.store_dir = "#{Rails.env}/uploads"
  config.enable_processing = false if Rails.env.test? or Rails.env.cucumber?
end
