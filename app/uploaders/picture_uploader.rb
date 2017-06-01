# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base
  # include mini_magick for image processing
  include CarrierWave::MiniMagick

  # storage option
  storage :file

  # directory for storing image
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fill: [65, 65]
  end

  version :lange do
    process resize_to_fit: [1050, 1050]
  end

  version :medium do
    process resize_to_fill: [900, 300]
  end

  version :small do
    process resize_to_fit: [360, 360]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
