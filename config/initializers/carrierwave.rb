CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: "AKIAICKOZWK3QEYOYLVQ",
    aws_secret_access_key: "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"
  }
  config.fog_directory = "storyvarnan_data"                    # required
  config.fog_public     = true                                 # optional, defaults to true
end