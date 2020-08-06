require 'shrine'
require 'shrine/storage/s3'

Shrine.plugin :activerecord

s3_options = {
    bucket: Figaro.env.S3_BUCKET,
    region: Figaro.env.S3_REGION,
    access_key_id: Figaro.env.S3_KEY,
    secret_access_key: Figaro.env.S3_SECRET
}

Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
    store: Shrine::Storage::S3.new(s3_options)
}

