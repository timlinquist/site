# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def featured_video
    @featured_video = Video.random
  end

  def most_recent_video
    @featured_video = Video.find(:first, :order => 'recorded_at desc')
  end

  def most_popular_video
    @most_popular_video = Video.random
  end

  def edit_image_tag
    image_tag('edit.png', :alt => 'Edit', :title => 'Edit')
  end

  def delete_image_tag
    image_tag('delete.png', :alt => 'Delete', :title => 'Delete')
  end
end
