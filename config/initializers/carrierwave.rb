CarrierWave.configure do |config|
	config.fog_credentials = {
		:provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAIGJ5KQKYM3ZIYAZQ',       # required
    :aws_secret_access_key  => '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',       # required
    :region                 => 'us-west-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'wespot-photo-uploads'                     # required
  # config.fog_host       = 'https://assets.wespot.com'            # optional, defaults to nil
  config.fog_public     = false                                  # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
