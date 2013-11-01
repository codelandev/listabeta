CarrierWave.configure do |config|
  config.storage = Rails.env.production? ? :fog : :file

  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     'AKIAIPKFA2ZITJFBMIAQ',
    aws_secret_access_key: '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',
  }

  config.fog_directory = 'listabetabr'
  config.store_dir = "#{Rails.env}/uploads"
  config.enable_processing = false if Rails.env.test? or Rails.env.cucumber?
end
