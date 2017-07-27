CarrierWave.configure do |config|
  #config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     ENV["AWS_ACCESS_KEY"],        # required
    aws_secret_access_key: ENV["AWS_SECRET_KEY"],        # required
  }
  config.fog_directory  = ENV["AWS_BUCKET"]
  config.fog_directory = 'beeprinted-stls'
  config.asset_host = 'https://beeprinted-stls.s3.amazonaws.com'            # required
end