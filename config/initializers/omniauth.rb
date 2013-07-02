Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '178653772295729', '184b2e162bd382479c7addd6e9ffa443'
end    