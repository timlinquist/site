namespace :attach do

  desc "Attach Video File"
  task :video, [:video_id, :file_name] => :environment do | t, args |

    v = Video.find(args[:video_id])

    puts "Attempting to attach a video file to '#{v.title}'."

    a = Asset.new

    base_dir = "#{RAILS_ROOT}/../../source/"
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

    base_dir = "#{RAILS_ROOT}/../../source/"
    file = "#{args[:file_name]}"

    a.data = File.new("#{base_dir}#{v.event.short_code}/#{file}")

    a.asset_type_id = 4  # Only thing unique about this vs. Video

    v.assets << a

    v.save
    puts "File has been attached."
  end

end
