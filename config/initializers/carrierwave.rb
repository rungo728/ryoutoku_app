#carrierwaveの設定呼び出し
require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

#保存先の分岐
CarrierWave.configure do |config|
  if Rails.env.production? #本番環境
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.secrets.aws_access_key_id,
      aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'ryoutoku'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/ryoutoku'
  else
    config.storage :file # 開発環境はpublic/uploades下に保存
    config.enable_processing = false if Rails.env.test? #test:処理をスキップ
  end
end