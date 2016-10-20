module LiquidMarkdown
  class Render
    #  setup your html layout layout to wrap around your LiquidMarkdown output
    # layout = "<html><head></head><body>{{yield}}</body></html>"
    attr_reader :template, :liquid_hash, :global_filter_proc
    attr_writer :layout
    attr_accessor :markdown_settings, :liquid_settings

    def initialize(template, liquid_hash={})
      @template = template
      @liquid_hash = liquid_hash
      @markdown_settings = {auto_ids: false, parse_block_html: true}
      @liquid_settings = {strict_filters: true, strict_variables: true}
      @global_filter_proc = ->(output) { output.is_a?(String) ? output.strip_html_tags : output }
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
      Kramdown::Document.new(template_value, @markdown_settings)
    end

    def liquidize
      Liquid::Template.parse(@template)
          .render(@liquid_hash, @liquid_settings, global_filter: @global_filter_proc)
    end

    def insert_into_template(rendered_content)
      return rendered_content if layout == ''
      layout.sub('{{yield}}', rendered_content)
    end

    def layout
      @layout ||= ''
    end
  end
end