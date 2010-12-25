namespace :attach do

  desc "Attach Video File"
  task :video, [:video_id, :file_name] => :environment do | t, args |

    v = Video.find(args[:video_id])

    puts "Attempting to attach a video file to '#{v.title}'."

    a = Asset.new

    base_dir = "#{RAILS_ROOT}/../../../source/"
    file = "#{args[:file_name]}"

    a.data = File.new("#{base_dir}#{v.event.short_code}/#{file}")

    a.asset_type_id = 1  # Only thing unique about this vs. Audio

    v.assets << a

    v.save
    puts "File has been attached."
  end

  desc "Attach a set of Video and Audio Files"
  task :all, [:video_id, :file_name_prefix] => :environment do | t, args |

    v = Video.find(args[:video_id])

    base_dir = "#{RAILS_ROOT}/../../../source/"
    file = "#{args[:file_name_prefix]}"

    ["small","large","xtra-large"].each do |size|
      a = Asset.new

      a.data = File.new("#{base_dir}#{v.event.short_code}/#{file}-#{size}.mp4")

      a.asset_type_id = 1
      v.assets << a
      v.save
      puts "\t#{size} video has been attached."

      if size == "small"
        puts "\tThis is the streaming video."
        v.streaming_video = a
        v.available = true
        v.save
      end
    end

    a = Asset.new
    a.data = File.new("#{base_dir}#{v.event.short_code}/#{file}.mp3")

    a.asset_type_id = 4
    v.assets << a

    puts "\taudio file has been attached."
  end

  desc "Attach Audio File"
  task :audio, [:video_id, :file_name] => :environment do | t, args |

    v=Video.find(args[:video_id])

    puts "Attempting to attach an audio file to '#{v.title}'."

    a = Asset.new

    base_dir = "#{RAILS_ROOT}/../../../source/"
    file = "#{args[:file_name]}"

    a.data = File.new("#{base_dir}#{v.event.short_code}/#{file}")

    a.asset_type_id = 4  # Only thing unique about this vs. Video

    v.assets << a

    v.save
    puts "File has been attached."
  end

  desc "Attach a set of older HD video Files"
  task :old_hd, [:video_id, :file_name_prefix] => :environment do | t, args |

    v = Video.find(args[:video_id])

    base_dir = "#{RAILS_ROOT}/../../../source/"
    file = "#{args[:file_name_prefix]}"

    ["small","large"].each do |size|
      a = Asset.new

      a.data = File.new("#{base_dir}#{v.event.short_code}/#{file}-#{size}.mp4")

      a.asset_type_id = 1
      v.assets << a

      if size == "small"
        v.streaming_video = a
        v.available = true
      end

      v.save

      puts "\t#{size} video has been attached."


    end
  end

  desc "Attach original flv & avi files with DW size"
  task :old_flv, [:video_id, :file_name_prefix] => :environment do | t, args |

    v = Video.find(args[:video_id])

    base_dir = "#{RAILS_ROOT}/../../../source/"
    file = "#{args[:file_name_prefix]}"

    ["_640x240.flv","_640x240.avi","_960x360.avi"]. each do |extension|
      a = Asset.new

      a.data = File.new("#{base_dir}#{v.event.short_code}/#{file}#{extension}")

      a.asset_type_id = 1
      v.assets << a

      if extension == "_640x240.flv"
        v.streaming_video = a
        v.available = true
      end

      v.save

      puts "\t#{extension} video has been attached."
    end
  end

  desc "Attach the results of a ZC encode job"
  task :zo, [:video_id] => :environment do | t, args |

    v = Video.find(args[:video_id])

    base_dir = "#{RAILS_ROOT}/../../../source/"

    puts "Attempting to attach Zencoder output to '#{v.title}'."


    # Attach the large and small videos
    ['small','large'].each do |size|
      file = "#{v.to_param}-#{size}.mp4"
      a = Asset.new
      a.data = File.new("#{base_dir}zencoder/#{file}")

      a.asset_type_id = 1  # Set asset_type to video

      a.width, a.height, a.duration = a.get_metadata

      v.assets << a

      v.save

      puts "File #{file} has been attached."

      if size == "small"
        puts "\tSetting this as the streaming video."
        v.streaming_video = a
        v.save
      end
    end

    # Attach the audio file
    file = "#{v.to_param}.mp3"
    a = Asset.new
    a.data = File.new("#{base_dir}zencoder/#{file}")

    a.asset_type_id = 4
    v.assets << a
    v.save

    puts "File #{file} has been attached."

    puts "Marking presentation #{v.id} - #{v.title} as available"
    v.available =true
    v.save
  end
end
