module ApplicationHelper

  def full_title(page_title = yield(:title))
    base_title = "Bookshelf App"
    return base_title if page_title.empty?
    "#{page_title} | #{base_title}"
  end
end
