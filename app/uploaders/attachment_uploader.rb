# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  #storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  process :converter

class Float
  def to_sn # to scientific notation
    "%E" % self
  end

  def self.from_sn str # generate a float from scientific notation
    ("%f" % str).to_f
  end
end



  def converter
    bosta = 0
    name ||= "#{current_path}"
    originalname = name.sub(/\.stl/i, '-original.stl')
    File.rename(name, "#{originalname}" )
    original = File.new(originalname, "r")
    tempLine = original.gets
    puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    if tempLine.include? "solid"
      puts 'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
      outFilename = name
      puts "#{name} is in ASCII format, converting to BINARY: #{outFilename}"
      outFile = File.new(outFilename, "w+b")
      outFile.write("\0" * 80) # 80 bit header - ignored
      outFile.write("FFFF")   # 4 bit integer # of triangles - filled later
      triCount = 0
      puts "#{triCount}"
      while temp = original.gets
        puts 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'
        if temp.valid_encoding?
         #temp.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
          next if temp =~ /^\s*$/ or temp.include? 'endsolid' # ignore whitespace
          temp.sub! /facet normal/, ''
          normal = temp.split(' ').map{ |num| Float.from_sn num }
          triCount += 1
          temp = original.gets # 'outer loop'

          temp = original.gets
          vertexA = temp.sub(/vertex/, '').split(' ').map{ |num| Float.from_sn num }
          temp = original.gets
          vertexB = temp.sub(/vertex/, '').split(' ').map{ |num| Float.from_sn num }
          temp = original.gets
          vertexC = temp.sub(/vertex/, '').split(' ').map{ |num| Float.from_sn num }

          temp = original.gets # 'endsolid'
          temp = original.gets # 'endfacet'

          outFile.write(normal.pack("FFF"))
          outFile.write(vertexA.pack("FFF"))
          outFile.write(vertexB.pack("FFF"))
          outFile.write(vertexC.pack("FFF"))
          outFile.write("\0\0")
        else
          bosta = 1
          #File.rename(name,"#{Rails.root}/public/uploads/post/#{post.id}/#{File.basename(post.attachment.path, ".*")}-binary.stl" ) 
          break
        end
      end
        if bosta == 0
          outFile.seek(80, IO::SEEK_SET)
          outFile.write([ triCount ].pack("V"))
          outFile.close
          File.delete(originalname)
        end
    else
      File.rename(originalname,name)
    end
    original.close
  end
  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end



  def extension_white_list
     %w(stl)
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
