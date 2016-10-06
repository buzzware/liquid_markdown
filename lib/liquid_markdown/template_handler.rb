module LiquidMarkdown
  module TemplateHandler
    class Text
      def self.call(template)
        %[
          LiquidMarkdown::Render.new(#{template.source.inspect}, values, :text)
        ]
      end
    end

    class HTML
      def self.call(template)
        %[
          LiquidMarkdown::Render.new(#{template.source.inspect}, values, :html)
        ]
      end
    end
  end
end