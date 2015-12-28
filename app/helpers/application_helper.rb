module ApplicationHelper

  def markdown(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = {
        autolink:           true,
        fenced_code_blocks: true,
        lax_spacing:        true,
        no_intra_emphasis:  true,
        strikethrough:      true,
        superscript:        true,
        underline:          true,
        quote:              true
    }
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end

end
