require 'liquid_markdown/version'
require 'redcarpet'
require 'redcarpet/render_strip'
require 'liquid'

module LiquidMarkdown
  def markdown(text, args={})
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       hard_wrap: true,
                                       autolink: true,
                                       filter_html: true,
                                       fenced_code_blocks: true,
                                       disable_indented_code_blocks: true,
                                       gh_blockcode: true)
    markdown.render(liquidize(text, args)).html_safe
  end

  def liquidize(content, args={})
    Liquid::Template.parse(content).render(args)
  end
end
