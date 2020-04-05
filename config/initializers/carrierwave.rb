unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIA5KM6ZOJJFCFEFCFT',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1',
    }
     config.fog_directory  = 'rails-image-hiroki'
     config.cache_storage = :fog
  end
end
