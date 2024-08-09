module ApplicationHelper

  def format_date(date)
    return "--" if date.blank?
    Date.parse(date).strftime("%Y-%m-%d")
  rescue ArgumentError
    "--"
  end

  def trimmed_description(description)
    return "" if description.blank?
    description = description.strip
    cut_index = description.index("**Links:**") || description.index("**Note:**") || description.index("**Original Webtoon:**")
    if cut_index
      description[0...cut_index].strip
    else
      description
    end
  end

end
