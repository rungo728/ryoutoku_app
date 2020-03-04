#carrierwaveの設定呼び出し
require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

#保存先の分岐
CarrierWave.configure do |config|
  # if Rails.env.production? #本番環境
  if Rails.env.production? || Rails.env.development? # 開発中もs3使う
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'ryoutoku'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/ryoutoku'

    # NOTE: AWS側の設定を変えなくても、この１行の設定でアップロードできた
    config.fog_public = true # ←コレ
    config.fog_credentials = {
      provider: 'AWS',
      # aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      # aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      aws_access_key_id: Rails.application.secrets.aws_access_key_id,
      aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
      region: 'ap-northeast-1'
    }

  else
    config.storage :file # 開発環境はpublic/uploades下に保存
    config.enable_processing = false if Rails.env.test? #test:処理をスキップ
  end
end