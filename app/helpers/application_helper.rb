module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Vancouver Info Co-op"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  # Strips out html tags and replaces each with a space.
  def space_tags(html_text)
    if html_text.present?
      (strip_tags(html_text.gsub '<', ' <').gsub '  ', ' ').gsub ' . ', '. '
    else
      html_text
    end
  end

end
