CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => "AKIAJX64DJXTNMXJCO7Q",
      :aws_secret_access_key  => "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",
      :region                 => 'sa-east-1' # Change this for different AWS region. Default is 'us-east-1'
  }
  config.fog_directory  = "beeprinted-bucket"
end