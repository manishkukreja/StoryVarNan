CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: "removed access id",
    aws_secret_access_key: "removed_access key"
  }
  config.fog_directory = "################"                    # required
  config.fog_public     = true                                 # optional, defaults to true
end
