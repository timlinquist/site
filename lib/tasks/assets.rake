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

    end

    a = Asset.new
    a.data = File.new("#{base_dir}#{v.event.short_code}/#{file}.mp3")

    a.asset_type_id = 4
    v.assets << a
    v.save
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

  desc "Attach a set of HD older video Files"
  task :old_hd, [:video_id, :file_name_prefix] => :environment do | t, args |

    v = Video.find(args[:video_id])

    base_dir = "#{RAILS_ROOT}/../../../source/"
    file = "#{args[:file_name_prefix]}"

    ["small","large"].each do |size|
      a = Asset.new

      a.data = File.new("#{base_dir}#{v.event.short_code}/#{file}-#{size}.mp4")

      a.asset_type_id = 1
      v.assets << a
      v.save
      puts "\t#{size} video has been attached."

    end
  end
end
