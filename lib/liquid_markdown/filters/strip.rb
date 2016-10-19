module LiquidMarkdown
  class Strip
    # def strip_html(hash)
    #   hash.each do |k, v|
    #     if v.is_a?(String)
    #       v.replace(v.strip_html)
    #     elsif v.is_a?(Hash)
    #       strip_html(v)
    #     elsif v.is_a?(Array)
    #       v.flatten.each { |x| strip_html(x) if x.is_a?(Hash) }
    #     end
    #   end
    # end

    def strip_html(input)
      input.strip_html
    end
  end
end

Liquid::Template.register_filter(LiquidMarkdown::Strip)