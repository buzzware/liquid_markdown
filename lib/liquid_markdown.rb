require 'liquid_markdown/version'
require 'liquid_markdown/render_template'

module LiquidMarkdown
  def self.render(template, values={})
    lm = Render::Template.new(template, values)
    lm.render
  end
end
