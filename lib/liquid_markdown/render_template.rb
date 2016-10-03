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
        template = Liquid::Template.parse(@template)
        template.render(stringify_keys @values)
      end

      # convert key symbols to strings (required for converting values in liquidize render call)
      # Example:
      # {a: 'b'} => {'a' => 'b'}
      def stringify_keys(hash)
        new_hash = {}
        hash.each {|k, v| new_hash[k.to_s] = v}
        new_hash
      end
    end
  end
end