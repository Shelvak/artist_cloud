class AudioUploader < CarrierWave::Uploader::Base
  def store_dir
    "private/#{model_store_dir}"
  end

  def model_store_dir
    model_id = ('%09d' % model.id).scan(/\d{3}/).join('/')

    [model.class.to_s.underscore, mounted_as, model_id].join('/')
  end

  def filename
    if original_filename.present? && super.present?
      return @_generated_filename if @_generated_filename

      name = model.try(:title) || super.chomp(File.extname(super))
      ext = File.extname(super)
      uuid ||= SecureRandom.hex

      @_generated_filename = [
        [name.parameterize, uuid].join('---'),
        ext
      ].join
    end
  end

  def url
    [model_store_dir, self.file.filename].join('/')
  rescue
    nil
  end

  def cache_dir
    '/tmp/uploads-cache'
  end

  def move_to_cache
    false
  end

  def move_to_store
    false
  end

  def extension_whitelist
    %w(mp3)
  end
end
