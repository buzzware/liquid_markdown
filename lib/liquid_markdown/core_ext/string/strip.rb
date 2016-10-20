class String
  # Returns a new string after stripping all html tags
  #
  #  string = "<hello>threre</hello>"
  #
  #  string.strip_html_tags => "there"
  def strip_html_tags
    empty = ''.freeze
    self.gsub(/<script.*?<\/script>/m, empty)
        .gsub(/<!--.*?-->/m, empty)
        .gsub(/<style.*?<\/style>/m, empty)
        .gsub(/<.*?>/m, empty)
  end
end