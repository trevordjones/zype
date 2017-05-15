module ApplicationHelper
  def video_thumbnail(video)
    yield video['thumbnails'][2].present? ? video['thumbnails'][2] : video['thumbnails'][0]
  end

  def video_duration(duration)
    "#{duration / 60}:#{duration % 60}"
  end
end
