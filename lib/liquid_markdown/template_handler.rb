module LiquidMarkdown
  module TemplateHandler
    class Text
      def self.call(template)
        %[
          LiquidMarkdown::TemplateHandler.render.new(#{template.source.inspect}, self, :text)
        ]
      end
    end

    class HTML
      def self.call(template)
        %[
          LiquidMarkdown::TemplateHandler.render.new(#{template.source.inspect}, self, :html)
        ]
      end
    end
  end
end