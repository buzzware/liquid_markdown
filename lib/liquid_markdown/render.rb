module LiquidMarkdown
  class Render
    #  setup your html layout layout to wrap around your LiquidMarkdown output
    # layout = "<html><head></head><body>{{yield}}</body></html>"
    attr_reader :template, :liquid_hash
    attr_writer :layout

    MARKDOWN_OPTIONS = {auto_ids: false, parse_block_html: true}
    LIQUID_OPTIONS = {strict_filters: true, strict_variables: true}

    def initialize(template, liquid_hash)
      @template = template
      @liquid_hash = liquid_hash
    end

    def html
      rendered_content = markdown(liquidize)
      insert_into_template(rendered_content.to_html)
    end

    def text
      rendered_content = markdown(liquidize)
      rendered_content.to_plain_text
    end

    def markdown(template_value)
      Kramdown::Document.new(template_value, MARKDOWN_OPTIONS)
    end

    def liquidize
      t = Liquid::Template.parse(@template)
      var = strip_html(liquid_hash)
      t.render(var, LIQUID_OPTIONS)
    end

    def insert_into_template(rendered_content)
      return rendered_content if layout == ''
      layout.sub('{{yield}}', rendered_content)
    end

    def layout
      @layout ||= ''
    end

    private

    def strip_html(input)
      if input.is_a?(Hash) or input.is_a?(Array)
        LiquidMarkdown::Strip.strip_html_values(input)
      else
        LiquidMarkdown::Strip.strip_html(input)
      end
    end
  end
end