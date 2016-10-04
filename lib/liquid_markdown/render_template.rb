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
        val = strip_html_values(@values)
        val = deep_stringify_keys(val)
        t.render(val, LIQUID_OPTIONS)
      end

      private

      # convert key symbols to strings (required for converting values in liquidize render call)
      # Example:
      # {a: 'b'} => {'a' => 'b'}
      def deep_stringify_keys(hash)
        s2s = lambda do |h|
                Hash === h ?
                  Hash[
                      h.map do |k, v|
                        [k.respond_to?(:to_sym) ? k.to_s : k, s2s[v]]
                      end
                  ] : h
              end
        s2s[hash]
      end

      def strip_html_values(hash)
        hash.each do |k, v|
          if v.is_a?(String)
            v.replace(strip_html(v))
          elsif v.is_a?(Hash)
            strip_html_values(v)
          elsif v.is_a?(Array)
            v.flatten.each { |x| strip_html_values(x) if x.is_a?(Hash) }
          end
        end
      end

      def strip_html(input)
        empty = ''.freeze
        input.to_s.gsub(/<script.*?<\/script>/m, empty).gsub(/<!--.*?-->/m, empty).gsub(/<style.*?<\/style>/m, empty).gsub(/<.*?>/m, empty)
      end
    end
  end
end