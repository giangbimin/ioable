module ApplicationHelper
  class ColorCode < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end
  end

  def markdown(content)
    opitions = {
      hard_wrap: true,
      filter_html: true
    }

    extensions = {
      space_after_headers: true,
      fenced_code_blocks: true,
      autolink: true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      no_intra_emphasis: true,
      disable_indented_code_blocks: true,
      lax_spacing: true,
      strikethrough: true,
      superscript: true
    }
    renderer = ColorCode.new(opitions)
    Redcarpet::Markdown.new(renderer, extensions).render(content).html_safe
  end
end
