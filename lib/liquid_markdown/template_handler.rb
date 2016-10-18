module LiquidMarkdown
  module TemplateHandler
    UNDERSCORE = '_'.freeze
    OBJECT_ATTRIBUTE_MATCHER = /%\{([a-z0-9_]+\.[a-z0-9_]+)\}/i

    def self.render(template, context, format)
      variables = expand_variables(template, extract_variables(context))
      liquid_variables = variables[:lmVariables]
      layout = variables[:lmLayout]
      lm = LiquidMarkdown::Render.new(template, liquid_variables)
      lm.layout = layout unless layout.nil?
      lm.send(format)
    end

    def self.expand_variables(template, variables)
      template.scan(OBJECT_ATTRIBUTE_MATCHER)
          .map(&:first)
          .each_with_object(variables) do |match, buffer|
        target, attribute = match.split('.')
        buffer[match.to_sym] = variables[target.to_sym].public_send(attribute)
      end
    end

    def self.extract_variables(context)
      context
          .instance_variable_get(:@_assigns)
          .each_with_object({}) do |(name, value), buffer|
        next if name.start_with?(UNDERSCORE)
        buffer[name.to_sym] = value
      end
    end

    class LIQMD
      def self.erb_handler
        @@erb_handler ||= ActionView::Template.registered_template_handler(:erb)
      end

      def self.call(template)
        compiled_source = erb_handler.call(template)
        if template.formats.include?(:html)
          "LiquidMarkdown::TemplateHandler.render(#{compiled_source}, self, :html)"
        else
          "LiquidMarkdown::TemplateHandler.render(#{compiled_source}, self, :text)"
        end
      end
    end
  end
end