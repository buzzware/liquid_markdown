require 'redcarpet'
require 'redcarpet/render_strip'
require 'redcarpet/render_man'
require 'liquid'
require 'liquid_markdown/strip'
require 'liquid_markdown/keys'

module LiquidMarkdown
  module Render
    class Template
      attr_accessor :template, :values

      MARKDOWN_OPTIONS = {hard_wrap: true, autolink: true, filter_html: true, fenced_code_block: true,
                          disable_indented_code_block: true, gh_blockcode: true}
      LIQUID_OPTIONS = {strict_filters: true, strict_variables: true}

      def initialize(template, values={})
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
        t = Liquid::Template.parse(@template)
        val = strip_html(@values)
        val = deep_stringify_keys(val)
        t.render(val, LIQUID_OPTIONS)
      end

      private

      def deep_stringify_keys(input_hash)
        LiquidMarkdown::Keys.deep_stringify_keys(input_hash)
      end

      def strip_html(input_hash)
        LiquidMarkdown::Strip.strip_html_values(input_hash)
      end
    end
  end
end