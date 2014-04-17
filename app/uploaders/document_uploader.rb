# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base
  storage :file

  def extension_white_list
    %w(pdf)
  end

  def store_dir
    Rails.root.join("store", Rails.env, model.class.to_s.underscore, mounted_as.to_s, model.id.to_s).to_s
  end

  def cache_dir
    Rails.root.join("tmp", "cache", "store", model.class.to_s.underscore, mounted_as.to_s, model.id.to_s).to_s
  end
end
