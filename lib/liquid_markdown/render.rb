module LiquidMarkdown
  class Render
    #  setup your html layout layout to wrap around your LiquidMarkdown output
    # layout = "<html><head></head><body>{{yield}}</body></html>"
    attr_reader :template, :values
    attr_writer :layout

    MARKDOWN_OPTIONS = {auto_ids: false, parse_block_html: true}
    LIQUID_OPTIONS = {strict_filters: true, strict_variables: true}

    def initialize(template, values={})
      @template = template
      @values = values
    end

    def render(type=:html)
      rendered_content = markdown(liquidize)
      content = insert_into_template(rendered_content)
      content = strip_html(content) if type == :text
      content
    end

    def markdown(template_value)
      Kramdown::Document.new(template_value, MARKDOWN_OPTIONS).to_html
    end

    def liquidize
      t = Liquid::Template.parse(@template)
      val = strip_html(@values)
      val = deep_stringify_keys(val)
      t.render(val, LIQUID_OPTIONS)
    end

    def insert_into_template(rendered_content)
      return rendered_content if layout == ''
      layout.sub('{{yield}}', rendered_content)
    end

    def layout
      @layout ||= ''
    end

    private

    def deep_stringify_keys(input_hash)
      LiquidMarkdown::Keys.deep_stringify_keys(input_hash)
    end

    def strip_html(input)
      if input.is_a?(Hash) or input.is_a?(Array)
        LiquidMarkdown::Strip.strip_html_values(input)
      else
        LiquidMarkdown::Strip.strip_html(input)
      end
    end
  end
end