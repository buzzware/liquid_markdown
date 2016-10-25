require 'panoramic'
require 'panoramic/orm/active_record'

module Panoramic
  module Orm
    def resolver(options={})
      LiquidMarkdown::Resolver.using self, options
    end
  end
end

module LiquidMarkdown
  class Resolver < ActionView::Resolver
    require "singleton"
    include Singleton

    def find_templates(name, prefix, _partial, details)
      contents = find_contents(name, prefix, details)
      return [] unless contents

      %i[html text].map do |format|
        identifier = "#{prefix}##{name} (#{format})"
        path = virtual_path(name, prefix)
        build_template(path, contents, identifier, format)
      end
    end

    def build_template(path, contents, identifier, format)
      handler = ActionView::Template.registered_template_handler(:liqmd)

      ActionView::Template.new(
          contents,
          identifier,
          handler,
          virtual_path: path, format: format
      )
    end

    def virtual_path(name, prefix)
      "#{prefix}/#{name}"
    end

    def find_contents(name, prefix, details)

    end
  end
end