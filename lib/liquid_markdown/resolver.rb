module LiquidMarkdown
  class Resolver < ActionView::Resolver
    FORMAT_TO_EXTENSION = {
        text: :mdt,
        html: :md
    }

    def find_templates(name, prefix, _partial, contents, outside_app_allowed = false)
      %i[html text].map do |format|
        identifier = "#{prefix}##{name} (#{format})"
        path = virtual_path(name, prefix)
        build_template(path, contents, identifier, format)
      end
    end

    def build_template(path, contents, identifier, format)
      ActionView::Template.new(
          contents,
          identifier,
          handler_for(format),
          virtual_path: path, format: format
      )
    end

    def handler_for(format)
      ActionView::Template
          .registered_template_handler(FORMAT_TO_EXTENSION.fetch(format))
    end

    def virtual_path(name, prefix)
      "#{prefix}/#{name}"
    end
  end
end