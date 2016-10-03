require 'redcarpet'
require 'redcarpet/render_strip'
require 'redcarpet/render_man'
require 'liquid'

module LiquidMarkdown
  module Render
    class Template
      attr_accessor :template, :values

      MARKDOWN_OPTIONS = {hard_wrap: true, autolink: true, filter_html: true, fenced_code_block: true,
                          disable_indented_code_block: true, gh_blockcode: true}

      def initialize(template, values)
        @template = template
        @values = values
      end

      def render
        markdown liquidize
      end

      def markdown(template_value)
        m = Redcarpet::Markdown.new(Redcarpet::Render::HTML, MARKDOWN_OPTIONS)
        m.render(template_value)
      end

      def liquidize
        Liquid::Template.parse(@template).render(@values)
      end
    end
  end
end