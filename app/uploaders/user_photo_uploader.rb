class UserPhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    path = "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"

    if Rails.env.test?
      path = "#{Rails.root}/spec/fixtures/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    path
  end

  def extension_whitelist
    %w[jpg jpeg png]
  end
end
