atom_feed do |feed|
  feed.title(@title)

  feed.updated(@updated)

  @videos.each do |video|
    feed.entry(video) do |entry|

      entry.title(h(video.title))
      entry.summary(truncate(strip_tags(video.abstract), :length => 100))

      entry.author do |author|
        video.presenters.each do |presenter|
          author.name(presenter.display_name)  
        end
      end
    end
  end
end