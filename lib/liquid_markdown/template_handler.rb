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
      def self.erb_handler
        @@erb_handler ||= ActionView::Template.register_template_handler(:erb)
      end
      
      def self.call(template)
        compiled_source = erb_handler.call(template)
        "LiquidMarkdown::Render.new(begin;#{compiled_source};end, {}, :html)"
      end
    end
  end
end