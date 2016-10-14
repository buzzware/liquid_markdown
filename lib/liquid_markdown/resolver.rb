module LiquidMarkdown
  class Resolver < ActionView::Resolver
    FORMAT_TO_EXTENSION = {
        text: :liqmdt,
        html: :liqmd
    }

    def find_templates(name, prefix, _partial, details, outside_app_allowed = false)
      contents = find_contents(name, prefix, details)
      return [] unless contents

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

    def translations
      I18n.backend.initialize unless I18n.backend.initialized?
      I18n.backend.send(:translations)
    end

    def find_contents(name, prefix, details)
      [details[:locale].try(:first) || I18n.locale, prefix, name, :body]
          .reduce(translations) do |buffer, key|
        buffer && buffer[key.to_sym]
      end
    end
  end
end