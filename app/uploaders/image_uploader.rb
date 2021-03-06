class ImageUploader < CarrierWave::Uploader::Base

#if Rails.env.production?
    # Include RMagick or MiniMagick support:
    include Cloudinary::CarrierWave
   include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
   
#else
   # Include RMagick or MiniMagick support:
   #include CarrierWave::RMagick
  
   # Choose what kind of storage to use for this uploader:
 # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
   #This is a sensible default for uploaders that are meant to be mounted:
  #def store_dir
   # "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  #end
  
   
#end


  # Choose what kind of storage to use for this uploader:
  #storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  #def store_dir
    #"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  #end

  # Provide a default URL as a default if there hasn't been a file uploaded:
    #def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
     #"default.jpg" 
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
   # end

# 画像の上限を700pxにする
  process :resize_to_limit => [500, 500]

  # 保存形式をJPGにする
  process :convert => 'jpg'

  # サムネイルを生成する設定
  version :thumb do
     process :resize_to_fit => [300, 300]
  end
  
  version :thumb_in do
    process :resize_and_pad => [300, 375]
  end

  version :thumb_gear do
    process :resize_to_fit => [400, 350]
  end

  version :thumb_edit do
    process :resize_to_fit => [400, 200]
  end

  def  size_range
      1..5.megabytes
  end


  # jpg,jpeg,gif,pngしか受け付けない
  def extension_white_list
    %w(jpg jpeg gif png)
  end

 # 拡張子が同じでないとGIFをJPGとかにコンバートできないので、ファイル名を変更
  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end

 # ファイル名は日本語が入ってくると嫌なので、下記のようにしてみてもいい。
 # 日付(20131001.jpgみたいなファイル名)で保存する
  #def filename
  #  time = Time.now
  #  name = time.strftime('%Y%m%d%H%M%S') + '.jpg'
  #  name.downcase
  #end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
