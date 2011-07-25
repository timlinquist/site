class Organization < ActiveRecord::Base
  has_many :organization_users

  has_many :users, :through => :organization_users

  has_many :conferences

  has_many :events, :through => :conferences

  def videos
    videos = []
    events.each do |event|
      event.videos.each do |v|
        videos << v
      end
    end
    return videos
  end

  def member_of? user
    user.organization_users.each do | ou |
      if ou.organization == self
        return true
      end
    end
    return false
  end
end
