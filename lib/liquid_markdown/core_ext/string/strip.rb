class String
  # Returns a new string after stripping all html tags
  #
  #  string = "<hello>threre</hello>"
  #
  #  string.strip_html => "there"
  def strip_html
    empty = ''.freeze
    input.to_s
        .gsub(/<script.*?<\/script>/m, empty)
        .gsub(/<!--.*?-->/m, empty)
        .gsub(/<style.*?<\/style>/m, empty)
        .gsub(/<.*?>/m, empty)
  end
end