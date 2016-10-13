# module LiquidMarkdown
#   module TemplateHandler
#     class Text
#       def self.text_handler
#         @@text_handler ||= ActionView::Template.register_template_handler(:liqmdt)
#       end
#
#       def self.call(template)
#         compiled_source = text_handler.call(template)
#         "LiquidMarkdown::Render.new(begin;#{compiled_source};end)"
#       end
#     end
#
#     class HTML
#       def self.html_handler
#         @@_handler ||= ActionView::Template.register_template_handler(:liqmd)
#       end
#
#       def self.call(template)
#         compiled_source = html_handler.call(template)
#         "LiquidMarkdown::Render.new(begin;#{compiled_source};end)"
#       end
#     end
#   end
# end

module LiquidMarkdown
  module TemplateHandler
    UNDERSCORE = "_".freeze
    OBJECT_ATTRIBUTE_MATCHER = /%\{([a-z0-9_]+\.[a-z0-9_]+)\}/i

    def self.render(template, context, format)
      puts context
      binding.pry
      variables = expand_variables(template, extract_variables(context))
      source = template.rstrip % variables
      ActionMailer::Markdown.public_send(format, source)
    end

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