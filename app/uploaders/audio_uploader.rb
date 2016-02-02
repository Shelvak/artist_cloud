class AudioUploader < CarrierWave::Uploader::Base
  def store_dir
    model_id = ('%09d' % model.id).scan(/\d{3}/).join('/')

    "private/#{model.class.to_s.underscore}/#{mounted_as}/#{model_id}"
  end

  def filename
    if original_filename.present? && super.present?
      name = model.try(:title) || super.chomp(File.extname(super))
      ext = File.extname(super)
      uuid = SecureRandom.hex

      [
        [name, uuid].join('---').parameterize,
        ext
      ].join
    end
  end

  def cache_dir
    '/tmp/uploads-cache'
  end

  def extension_whitelist
    %w(mp3)
  end
end
