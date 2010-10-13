atom_feed do |feed|
  feed.title(@title)

  feed.updated(@updated)

  @videos.each do |video|
    feed.entry(video) do |entry|

      entry.title(h(video.title))
      entry.summary(truncate(strip_tags(video.abstract), :length => 100))
      entry.published(
        video.post_date.nil? ? video.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ") :
          video.post_date.strftime("%Y-%m-%dT%H:%M:%SZ"))
      entry.author do |author|
        video.presenters.each do |presenter|
          author.name(presenter.display_name)
        end
      end
      video.assets do |asset|
        entry.link('url' => asset.data.url, 'rel' => 'enclosure')
      end
    end
  end
end