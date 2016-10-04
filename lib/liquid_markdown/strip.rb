module LiquidMarkdown
  class Strip
    def self.strip_html_values(hash)
      hash.each do |k, v|
        if v.is_a?(String)
          v.replace(strip_html(v))
        elsif v.is_a?(Hash)
          strip_html_values(v)
        elsif v.is_a?(Array)
          v.flatten.each { |x| strip_html_values(x) if x.is_a?(Hash) }
        end
      end
    end

    def self.strip_html(input)
      empty = ''.freeze
      input.to_s.gsub(/<script.*?<\/script>/m, empty).gsub(/<!--.*?-->/m, empty).gsub(/<style.*?<\/style>/m, empty).gsub(/<.*?>/m, empty)
    end
  end
end