class PostContentPresenter

  IMG_REGEXP = /<img[^>]*src="([^"]+)[^>]*style="[^"]*width:[ ]{0,1}([0-9]+)px;[^"]*height:[ ]{0,1}([0-9]+)px;[^"]*"[^>]*>/m

  def initialize(post)
    @post = post
  end

  def content
    new_content = @post.content.gsub(IMG_REGEXP, '<div class=\'fullscreen background parallax image-gallery\' style=\'width:100%; background-image:url(\1);\' data-mfp-src=\'\1\' data-img-width=\2 data-img-height=\3 data-diff=200></div>')
    new_content.html_safe
  end
end