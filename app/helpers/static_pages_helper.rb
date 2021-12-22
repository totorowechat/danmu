# frozen_string_literal: true

module StaticPagesHelper
  def full_title(page_title = '')
    base_title = 'Danmaku'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
